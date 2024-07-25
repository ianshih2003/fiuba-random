.begin
.org 2048

	ld [A], %r1
	ld [B], %r2
	addcc %r1, %r2, %r3

A: 3
B: 4

.end
