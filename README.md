tmasm
=====

_TMASM_ is an assembler for an obfuscated Turing Machine emulator.

I don't know why.  Like a few other projects, I don't actually remember writing this.  I _do_ vaguely remember thinking about it.  But writing a full assembler?  Using lex and yacc?

Believe it or not, though, that's not the weirdest part of this.  I didn't write the virtual machine.  That already existed...as [Paul E. Black's 1989 IOCCC entry](http://www.ioccc.org/1989/paul.hint) ([source](http://www.ioccc.org/1989/paul.c), compile and go).

Not included here is what appears to have been a first, tentative step at de-obfuscating the code, which I assume I sensibly gave up on.  I'm also not about to include somebody else's code without permission or a license.

I might be convinced to do so if I rewrite it, but otherwise, you'll need to rely on the original.

Syntax
------

I can't believe you're still reading this...

Every Turing Machine assembler instruction has the same format:

 - __Current State__:  Represented as a number.  The maximum number is hard-coded as 127.

 - __/__, obligatory syntax.

 - __Condition__:  The character (preceded by a `\`` back-tick) expected on the tape at this position.

 - __:__, apparently because I said so.

 - __Target State__:  The number of the state to which we transition when the condition is true.

 - __/__, like before.

 - __Output__:  Character (again, preceded by a `\`` back-tick) to write to the tape.

 - __Direction__:  An `L` or `R` to optionally move the tape head.

 - __Debug__:  Optionally, a `p` can be added to (I believe) activate the trace routine, though I'm not entirely convinced of that.

A typical line looks something like:

    42/`1 : 13/`0 R p

Yes, I used lex and yacc to do this, for some reason.

Usage
-----

The first command-line parameter is the source.  The second is your output binary.

If you don't supply the second parameter, the assembler automatically chooses `a.out` to guarantee conflict with any lazily-compiled C code you might have around.  If you don't supply the first parameter, the assembler reads from `stdin`, which won't confuse you at all.

Run the resulting binary through Black's emulator, and at least in theory, you'll get some kind of result, especially if the commented code (the trace routine) is turned on.

