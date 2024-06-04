#pragma once

/*
Copyright (c) 2016 Sam Bloomberg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#include <unordered_map>
#include <functional>
#include <vector>
#include <algorithm>
#include <stdint.h>
#include <type_traits>

//////////////////////////////////////////////////////////////////////////
// SETTINGS //
//////////////////////////////////////////////////////////////////////////


// Define what you want to pass to the tick() function by defining ECS_TICK_TYPE before including this header,
// or leave it as default (float).
// This is really messy to do but the alternative is some sort of slow custom event setup for ticks, which is silly.

// Add this before including this header if you don't want to pass anything to tick()
//#define ECS_TICK_TYPE_VOID
#ifndef ECS_TICK_TYPE
#define ECS_TICK_TYPE ECS::DefaultTickData
#endif

// Define what kind of allocator you want the world to use. It should have a default constructor.
#ifndef ECS_ALLOCATOR_TYPE
#define ECS_ALLOCATOR_TYPE std::allocator<ECS::Entity>
#endif

// Define ECS_TICK_NO_CLEANUP if you don't want the world to automatically cleanup dead entities
// at the beginning of each tick. This will require you to call cleanup() manually to prevent memory
// leaks.
//#define ECS_TICK_NO_CLEANUP

// Define ECS_NO_RTTI to turn off RTTI. This requires using the ECS_DEFINE_TYPE and ECS_DECLARE_TYPE macros on all types
// that you wish to use as components or events. If you use ECS_NO_RTTI, also place ECS_TYPE_IMPLEMENTATION in a single cpp file.
//#define ECS_NO_RTTI

#ifndef ECS_NO_RTTI

#include <typeindex>
#include <typeinfo>
#define ECS_TYPE_IMPLEMENTATION

#else

#define ECS_TYPE_IMPLEMENTATION \
        ECS::TypeIndex ECS::Internal::TypeRegistry::nextIndex = 1; \
        \
        ECS_DEFINE_TYPE(ECS::Events::OnEntityCreated);\
        ECS_DEFINE_TYPE(ECS::Events::OnEntityDestroyed); \

#endif

//////////////////////////////////////////////////////////////////////////
// CODE //
//////////////////////////////////////////////////////////////////////////

namespace ECS
{
#ifndef ECS_NO_RTTI
        typedef std::type_index TypeIndex;

#define ECS_DECLARE_TYPE
#define ECS_DEFINE_TYPE(name)

        template<typename T>
        TypeIndex getTypeIndex()
        {
                return std::type_index(typeid(T));
        }

#else
        typedef uint32_t TypeIndex;

        namespace Internal
        {
                class TypeRegistry
                {
                public:
                        TypeRegistry()
                        {
                                index = nextIndex;
                                ++nextIndex;
                        }

                        TypeIndex getIndex() const
                        {
                                return index;
                        }

                private:
                        static TypeIndex nextIndex;
                        TypeIndex index;
                };
        }

#define ECS_DECLARE_TYPE public: static ECS::Internal::TypeRegistry __ecs_type_reg
#define ECS_DEFINE_TYPE(name) ECS::Internal::TypeRegistry name::__ecs_type_reg

        template<typename T>
        TypeIndex getTypeIndex()
        {
                return T::__ecs_type_reg.getIndex();
        }
#endif

        class World;
        class Entity;

        typedef float DefaultTickData;
        typedef ECS_ALLOCATOR_TYPE Allocator;

        // Do not use anything in the Internal namespace yourself.
        namespace Internal
        {
                template<typename... Types>
                class EntityComponentView;

                class EntityView;

                struct BaseComponentContainer
                {
                public:
                        virtual ~BaseComponentContainer() { }

                        // This should only ever be called by the entity itself.
                        virtual void destroy(World* world) = 0;

                        // This will be called by the entity itself
                        virtual void removed(Entity* ent) = 0;
                };

                class BaseEventSubscriber
                {
                public:
                        virtual ~BaseEventSubscriber() {};
                };

                template<typename... Types>
                class EntityComponentIterator
                {
                public:
                        EntityComponentIterator(World* world, size_t index, bool bIsEnd, bool bIncludePendingDestroy);

                        size_t getIndex() const
                        {
                                return index;
                        }

                        bool isEnd() const;

                        bool includePendingDestroy() const
                        {
                                return bIncludePendingDestroy;
                        }

                        World* getWorld() const
                        {
                                return world;
                        }

                        Entity* get() const;

                        Entity* operator*() const
                        {
                                return get();
                        }

                        bool operator==(const EntityComponentIterator<Types...>& other) const
                        {
                                if (world != other.world)
                                        return false;

                                if (isEnd())
                                        return other.isEnd();

                                return index == other.index;
                        }

                        bool operator!=(const EntityComponentIterator<Types...>& other) const
                        {
                                if (world != other.world)
                                        return true;

                                if (isEnd())
                                        return !other.isEnd();

                                return index != other.index;
                        }

                        EntityComponentIterator<Types...>& operator++();

                private:
                        bool bIsEnd = false;
                        size_t index;
                        class ECS::World* world;
                        bool bIncludePendingDestroy;
                };

                template<typename... Types>
                class EntityComponentView
                {
                public:
                        EntityComponentView(const EntityComponentIterator<Types...>& first, const EntityComponentIterator<Types...>& last);

                        const EntityComponentIterator<Types...>& begin() const
                        {
                                return firstItr;
                        }

                        const EntityComponentIterator<Types...>& end() const
                        {
                                return lastItr;
                        }

                private:
                        EntityComponentIterator<Types...> firstItr;
                        EntityComponentIterator<Types...> lastItr;
                };
        }

        /**
        * Think of this as a pointer to a component. Whenever you get a component from the world or an entity,
        * it'll be wrapped in a ComponentHandle.
        */
        template<typename T>
        class ComponentHandle
        {
        public:
                ComponentHandle()
                        : component(nullptr)
                {
                }

                ComponentHandle(T* component)
                        : component(component)
                {
                }

                T* operator->() const
                {
                        return component;
                }

                operator bool() const
                {
                        return isValid();
                }

                T& get()
                {
                        return *component;
                }

                bool isValid() const
                {
                        return component != nullptr;
                }

        private:
                T* component;
        };

        /**
        * A system that acts on entities. Generally, this will act on a subset of entities using World::each().
        *
        * Systems often will respond to events by subclassing EventSubscriber. You may use configure() to subscribe to events,
        * but remember to unsubscribe in unconfigure().
        */
        class EntitySystem
        {
        public:
                virtual ~EntitySystem() {}

                /**
                * Called when this system is added to a world.
                */
                virtual void configure(World* world)
                {
                }

                /**
                * Called when this system is being removed from a world.
                */
                virtual void unconfigure(World* world)
                {
                }

                /**
                * Called when World::tick() is called. See ECS_TICK_TYPE at the top of this file for more
                * information about passing data to tick.
                */
#ifdef ECS_TICK_TYPE_VOID
                virtual void tick(World* world)
#else
                virtual void tick(World* world, ECS_TICK_TYPE data)
#endif
                {
                }
        };

        /**
        * Subclass this as EventSubscriber<EventType> and then call World::subscribe() in order to subscribe to events. Make sure
        * to call World::unsubscribe() or World::unsubscribeAll() when your subscriber is deleted!
        */
        template<typename T>
        class EventSubscriber : public Internal::BaseEventSubscriber
        {
        public:
                virtual ~EventSubscriber() {}

                /**
                * Called when an event is emitted by the world.
                */
                virtual void receive(World* world, const T& event) = 0;
        };

        namespace Events
        {
                // Called when a new entity is created.
                struct OnEntityCreated
                {
                        ECS_DECLARE_TYPE;

                        Entity* entity;
                };

                // Called when an entity is about to be destroyed.
                struct OnEntityDestroyed
                {
                        ECS_DECLARE_TYPE;

                        Entity* entity;
                };

                // Called when a component is assigned (not necessarily created).
                template<typename T>
                struct OnComponentAssigned
                {
                        ECS_DECLARE_TYPE;

                        Entity* entity;
                        ComponentHandle<T> component;
                };

                // Called when a component is removed
                template<typename T>
                struct OnComponentRemoved
                {
                        ECS_DECLARE_TYPE;

                        Entity* entity;
                        ComponentHandle<T> component;
                };

#ifdef ECS_NO_RTTI
                template<typename T>
                ECS_DEFINE_TYPE(ECS::Events::OnComponentAssigned<T>);
                template<typename T>
                ECS_DEFINE_TYPE(ECS::Events::OnComponentRemoved<T>);
#endif
        }


        /**
        * A container for components. Entities do not have any logic of their own, except of that which to manage
        * components. Components themselves are generally structs that contain data with which EntitySystems can
        * act upon, but technically any data type may be used as a component, though only one of each data type
        * may be on a single Entity at a time.
        */
        class Entity
        {
        public:
                friend class World;

                const static size_t InvalidEntityId = 0;

                // Do not create entities yourself, use World::create().
                Entity(World* world, size_t id)
                        : world(world), id(id)
                {
                }

                // Do not delete entities yourself, use World::destroy().
                ~Entity()
                {
                        removeAll();
                }

                /**
                * Get the world associated with this entity.
                */
                World* getWorld() const
                {
                        return world;
                }

                /**
                * Does this entity have a component?
                */
                template<typename T>
                bool has() const
                {
                        auto index = getTypeIndex<T>();
                        return components.find(index) != components.end();
                }

                /**
                * Does this entity have this list of components? The order of components does not matter.
                */
                template<typename T, typename V, typename... Types>
                bool has() const
                {
                        return has<T>() && has<V, Types...>();
                }

                /**
                * Assign a new component (or replace an old one). All components must have a default constructor, though they
                * may have additional constructors. You may pass arguments to this function the same way you would to a constructor.
                *
                * It is recommended that components be simple types (not const, not references, not pointers). If you need to store
                * any of the above, wrap it in a struct.
                */
                template<typename T, typename... Args>
                ComponentHandle<T> assign(Args&&... args);

                /**
                * Remove a component of a specific type. Returns whether a component was removed.
                */
                template<typename T>
                bool remove()
                {
                        auto found = components.find(getTypeIndex<T>());
                        if (found != components.end())
                        {
                                found->second->removed(this);
                                found->second->destroy(world);

                                components.erase(found);

                                return true;
                        }

                        return false;
                }

                /**
                * Remove all components from this entity.
                */
                void removeAll()
                {
                        for (auto pair : components)
                        {
                                pair.second->removed(this);
                                pair.second->destroy(world);
                        }

                        components.clear();
                }

                /**
                * Get a component from this entity.
                */
                template<typename T>
                ComponentHandle<T> get();

                /**
                * Call a function with components from this entity as arguments. This will return true if this entity has
                * all specified components attached, and false if otherwise.
                */
                template<typename... Types>
                bool with(typename std::common_type<std::function<void(ComponentHandle<Types>...)>>::type view)
                {
                        if (!has<Types...>())
                                return false;

                        view(get<Types>()...); // variadic template expansion is fun
                        return true;
                }

                /**
                * Get this entity's id. Entity ids aren't too useful at the moment, but can be used to tell the difference between entities when debugging.
                */
                size_t getEntityId() const
                {
                        return id;
                }

                bool isPendingDestroy() const
                {
                        return bPendingDestroy;
                }

        private:
                std::unordered_map<TypeIndex, Internal::BaseComponentContainer*> components;
                World* world;

                size_t id;
                bool bPendingDestroy = false;
        };

        /**
        * The world creates, destroys, and manages entities. The lifetime of entities and _registered_ systems are handled by the world
        * (don't delete a system without unregistering it from the world first!), while event subscribers have their own lifetimes
        * (the world doesn't delete them automatically when the world is deleted).
        */
        class World
        {
        public:
                using WorldAllocator = std::allocator_traits<Allocator>::template rebind_alloc<World>;
                using EntityAllocator = std::allocator_traits<Allocator>::template rebind_alloc<Entity>;
                using SystemAllocator = std::allocator_traits<Allocator>::template rebind_alloc<EntitySystem>;
                using EntityPtrAllocator = std::allocator_traits<Allocator>::template rebind_alloc<Entity*>;
                using SystemPtrAllocator = std::allocator_traits<Allocator>::template rebind_alloc<EntitySystem*>;
                using SubscriberPtrAllocator = std::allocator_traits<Allocator>::template rebind_alloc<Internal::BaseEventSubscriber*>;
                using SubscriberPairAllocator = std::allocator_traits<Allocator>::template rebind_alloc<std::pair<const TypeIndex, std::vector<Internal::BaseEventSubscriber*, SubscriberPtrAllocator>>>;

                /**
                * Use this function to construct the world with a custom allocator.
                */
                static World* createWorld(Allocator alloc)
                {
                        WorldAllocator worldAlloc(alloc);
                        World* world = std::allocator_traits<WorldAllocator>::allocate(worldAlloc, 1);
                        std::allocator_traits<WorldAllocator>::construct(worldAlloc, world, alloc);

                        return world;
                }

                /**
                * Use this function to construct the world with the default allocator.
                */
                static World* createWorld()
                {
                        return createWorld(Allocator());
                }

                // Use this to destroy the world instead of calling delete.
                // This will emit OnEntityDestroyed events and call EntitySystem::unconfigure as appropriate.
                void destroyWorld()
                {
                        WorldAllocator alloc(entAlloc);
                        std::allocator_traits<WorldAllocator>::destroy(alloc, this);
                        std::allocator_traits<WorldAllocator>::deallocate(