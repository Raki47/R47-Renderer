; Matrix functions for use In the renderer, will be crucial for any moderate to advanced camera systems

.DATA

; 3x3 matrices used for 2D rendering
; Using 'M11' as an example, the M stands for Matrix, the first number Is the row, second number Is the collumn
; 'REAL8' defines a x64 floating point, '?' indicates that the field Is unninitialised

MATRIX3_IDENTITY STRUCT
	M11 REAL8 ?
	M12 REAL8 ?
	M13 REAL8 ?
	M21 REAL8 ?
	M22 REAL8 ?
	M23 REAL8 ?
	M31 REAL8 ?
	M32 REAL8 ?
	M33 REAL8 ?

MATRIX3_IDENTITY ENDS


MATRIX3_TRANSLATE STRUCT


MATRIX3_TRANSLATE ENDS


MATRIX3_SCALE STRUCT


MATRIX3_SCALE ENDS


MATRIX3_ROTATE STRUCT


MATRIX3_ROTATE ENDS


MATRIX3_MULTIPLY STRUCT


MATRIX3_MULTIPLY ENDS


; 4x4 matrices used for 3D rendering
COMMENT !


MATRIX4_IDENTITY STRUCT
	_M11 REAL8 ?
	_M12 REAL8 ?
	_M13 REAL8 ?
	_M14 REAL8 ?
	_M21 REAL8 ?
	_M22 REAL8 ?
	_M23 REAL8 ?
	_M24 REAL8 ?
	_M31 REAL8 ?
	_M32 REAL8 ?
	_M33 REAL8 ?
	_M34 REAL8 ?


MATRIX4_IDENTITY ENDS


MATRIX4_TRANSLATE STRUCT


MATRIX4_TRANSLATE ENDS


MATRIX4_SCALE STRUCT


MATRIX4_SCALE ENDS


MATRIX4_ROTATE STRUCT


MATRIX4_ROTATE ENDS


MATRIX4_MULTIPLY STRUCT


MATRIX4_MULTIPLY ENDS


!

.CODE

END
