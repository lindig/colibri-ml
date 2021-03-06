
# Colibri

This is Colibri, a library and a demo application for formal concept
analysis implemented in Objective Caml.

## Concept Analysis

Formal Concept Analysis is an algebraic theory for binary relations.
Every binary relation induces a complete lattice of so-called concepts.
Concept lattices is also known as Galois Lattices. The definite text
book for concept analysis is:

    Formal Concept Analysis : Mathematical Foundations
    by  Bernhard Ganter, Rudolf Wille, C. Franzke
    Springer, 1998.

    http://www.amazon.com/gp/product/3540627715/104-1061763-0179914

## Example

What are concepts and what is a concept lattice? A binary relation
over objects and associated attributes may be represented
as a context table:

    objects		attributes
    -------------------------------------------------------------
    chmod:		change file mode permission ;
    chown:		change file group owner;
    fstat:		get file status ;
    fork:		create new process ;
    chdir:		change directory ;
    mkdir:		create directory new ;
    open:		create file open read write;
    read:		file input read ;
    rmdir:		directory file remove ;
    write:		file output write ;
    creat:		create file new ;
    access:		access check file ;

Here objects are Unix system calls and attributes are associated terms
describing a system call. Any set of objects shares a (possibly empty)
set of common attributes: the set {chdir,mkdir} shares {directory} for
example. The same is true for attribute sets which share common
objects. So every set of objects determines a set of common attributes
and every set of attributes determines a set of common objects,
forming a pair of object and attribute set. A pair (O,A) of such two
sets is called a concept, if the following holds: the set of
attributes common to the objects in O is A and the set of objects
commonly shared by the attributes in A is O. Every binary relation
induces such concepts and the program calculates them.

All concepts from a binary relation are (partially) ordered and even
more, form a lattice. Concepts are ordered by (O1,A1) <= (O2,A2) if and
only if A1 <= A2 holds. Concepts computes for every concept its super-
and subconcepts and permits to output the lattice structure. The
complete set of concepts from the example above is shown below. Each
concept contains a unique number, the set of objects and the set of
attributes.

    {0 {access creat write rmdir read open mkdir chdir fork fstat chown chmod} {}}
    {1 {access creat write rmdir read open fstat chown chmod} {file}}
    {2 {access} {file check access}}
    {3 {creat open mkdir fork} {create}}
    {4 {creat open} {file create}}
    {5 {creat mkdir fork} {new create}}
    {6 {creat} {file new create}}
    {7 {write open} {file write}}
    {8 {write} {file write output}}
    {9 {rmdir mkdir chdir} {directory}}
    {10 {rmdir} {file remove directory}}
    {11 {read open} {file read}}
    {12 {read} {file read input}}
    {13 {open} {file create write read open}}
    {14 {mkdir} {new create directory}}
    {15 {chdir chown chmod} {change}}
    {16 {chdir} {directory change}}
    {17 {fork} {new create process}}
    {18 {fstat} {file status get}}
    {19 {chown chmod} {file change}}
    {20 {chown} {file change owner group}}
    {21 {chmod} {file change permission mode}}
    {22 {} {file check access new create write output remove directory
            read input open change process status get owner group permission mode}}

## Compilation

Take a look at the `Makefile`. You might want to change `PREFIX` but for a
first try there is no need to change anything. The build process assumes a
Unix system and an OCaml installation. It does not depend on libraries
outside of the OCaml standard libraries
    
    make
    make install

## User Manual

There is a Unix man page in doc/ (after compilation). You can format it
using nroff:

    nroff -man doc/colibri.1 | less

## Development Documentation

This software is implemented as a literate program - the source code are
the `*.nw` (NoWeb) files that contain LaTeX documentation and OCaml source
code. For compilation source code is automatically extracted.

## Applications

Directory `doc/` contains a [paper](doc/mining-patterns.pdf) that uses
formal concept analysis to find anomalies in software that may indicate
bugs. The idea is to find frequent patterns and few deviations from these
patterns could indicate a problem.  Pattern and deviations from patterns
are formalized in a framework of formal concepts. This was later used in
this paper:

    @inproceedings{wasylkowski2007FSE,
        title={Detecting object usage anomalies},
        author={Wasylkowski, Andrzej 
            and Zeller, Andreas 
            and Lindig, Christian},
        booktitle={Proceedings of the the 6th joint meeting of the European
            software engineering conference and the 
            ACM SIGSOFT symposium on The foundations of 
            software engineering},
        pages={35--44},
        year={2007},
        organization={ACM}
    }

You can find some more papers using formal concept analysis here:

    http://scholar.google.de/citations?user=M8QezN0AAAAJ

##  Download

Source code is available from GitHub

    https://github.com/lindig/colibri-ml.git

## Author 

Christian Lindig
lindig@gmail.com


