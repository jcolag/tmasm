; SPDX-FileCopyrightText: 2016 John Colagioia <john@colagioia.net>

; SPDX-License-Identifier: GPL-3.0-or-later

; Sample Turing Machine program to invert a tape and print the new Zeros

23 / `1 : 23 / `0 R .           ; Make 1s into 0s (and print)

23 / `0 : 23 / `1 R             ; and make 0s into 1s (but don't print)
