# Setting The Scene

## Some Terminology

*Data model*: An abstract, self-contained, logical definition of the data structures, data operators, and so forth, that together make up the abstract machine with which users interact.

This is the meaning we have in mind when we talk about he relational model in particular: The data structures in the relational model are relations, of course, and the data operators are relational operators projection, join and the rest.

*Data Model(second sense)*: A model of the data -- especially the persistent data of some particular enterprise.

In other words, a data model in the second sense is just a logical database design.

Analogy:

* A data model in the first sense is like a programming language, whose constructs can be used to solve many specific problems but in and of themselves have no direct connection with any such specific problem.
* A data model in the second sense is like a specific program written in that language -- it uses the facilities provided by the model, in the first sense of that term, to solve some specific problem.

If follows from all of the above that if we are talking about data models in the second sense, then we might reasonably speak of "relational models".

If we are talking about data models in the first sense, then *there's only one relational model*, and it's *the* relational model.

## Keys

A *candidate key* is basically just a unique identifier; in other words, it's a combination of attributes. Often, but not always, a "combination" consisting of just a single attributes.

Candidate keys are always combinations, or *sets*, of attributes, the conventional representation of a set on paper is as a commalist (list of things that separated by comma) of elements enclosed in brace.

A *primary key* is a candidate key that's been singled out in some way for some kind of special treatment. From now on, I'll use the term *key*, unqualified, to mean any candidate keys.

## More terminology:

* **composite**:A key involving two or more attributes
* **alternate keys**: If a given relvar has two or more keys and one is chosen as primary, then the others are sometimes said to be *alternate* keys.
* **forign keys**: a combination, or set, of attributes `FK` in some relvar `R2` such that each `FK` value is required to be equal to some value of some key `K` in some relvar `R1`

# Prerequisites

## Overview

* Any given database consist of *relation varialbes* (relvars for short)
* The value of any given relvar at any given time is a *relation value* (relation for short)
* Every relvar represent a certain *predicate*.
* Within any given relvar, every tuple represents a certain *predicate*.

## Relations and Relvars

There's a logical difference between relation values and relation variables.

Relations have two parts, a *heading* and a *body*. Basically, the heading is a set of attributes, and the body is a set of tuples that conform to that heading.

## Predicates And Propositions

All relvars are supposed to represent some portion of the real world. To be more precise, the heading of that relvar represents a ertain *predicate*, meaning it's a kind of generic statement about some portion of the real world.

You can think of a predicate as a *truth valued funciton*. It has a set of parameters; it returns a result when it's invoked, and that result is either TRUE or FALSE.

*Proposition*, which in logic is something that evaluates to either TRUE or FALSE unconditionally.

* Every relvar has an associated predicate, called *relvar predicate* for the relvar in question
* Let relvar `R` have predicate `P`. Then every tuple `t` appearing in `R` at some given time `T` can be regarded as representing a certain proposition `p`, derived by invoking `P` at that time `T` with the attribute values from `t` as arguments.
* And we assume by convention that each proposition `p` obtained in this manner evaluates to TRUE.

To sum up: A given relvar `R` contains, at any given time, *all* and *only* the tuples that represent true propositions at the time in question 

* **Definition**: Let relvar `R` have predicate `P`. Then the **Closed World Assumption** (CWA) says:

1. if tuple `t` appears in `R` at time `T`, then the instantiation `p` of `P` corresponding to `t` is assumed to be true at time `T`; conversely,
* If tuple `t` plausibly could appear in `R` at time `T` but doesn't, then the instantiation `p` of `P` corresponding to `t` is assumed to be false at time `T`. 

Consider the supplier and parts tables:

S:

<table>
<tr>
<th>SNO</th><th>SNAME</th><th>STATUS</th><th>CITY</th>
</tr>
</table>

P:

<table>
<th>PNO</th><th>PNAME</th><th>COLOR</th><th>WEIGHT</th><th>CITY</th>
</tr>
</table>

SP:
<table>
<tr>
<th>SNO</th><th>PNO</th><th>QTY</th>
</tr>
</table>

Here now are definitions of the three relvars:

    VAR S BASE RELATION
      { SNO CHAR, SNAME CHAR, STATUS INTEGER, CITY CHAR}
        KEY { SNO } ;

    VAR P BASE RELATION
      { PNO CHAR, PNAME CHAR, COLOR CHAR, WEIGHT RATIONAL, CITY CHAR }
      KEY { PNO } ;

    VAR SP BASE RELATION
      {SNO CHAR, PNO CHAR, QTY INTEGER }
        KEY{ SNO, PNO }
        FOREIGN KEY { SNO } REFERENCES S
        FOREIGN KEY { PNO } REFERENCES P ;

As you can see, each of those definitions include a KEY specification, which means that every relation that might ever be assigned to any of those relvars is required to satisfy the corresponding *key constrait*. For example, uniqueness. What's more, we have to specify the following *funcitonal dependency* 
    { CITY } -> {STATUS}
You can read this FD, informally, as `STATUS` is *functionally dependent on CITY*, or as *CITY functionally determines STATUS*. 

What it means is that every relation that might ever be assigned to relvar `S` is required to satisfy the constraint that might ever be assigned to relvar `S` is required to satisfy the constraint that if two tuples in that relation have the same CITY value, then they must also have the same STATUS value.

So the syntax for that purpose:
    CONSTRAINT XCT
        COUNT （ S { CITY } ) = COUNT ( S { CITY, STATUS } ) ;

*Explanation* In tutorial D, an expression of the form `r{A1, ..., An} denotes the projection of relation `r` on attributes `A1,..., An`. If the current value of relvar `S` is `s`(a relation), therefore:

* The expression S{CITY}

# Functional Dependencies, BOYCE/CODD NORMAL FORM, AND RELATED MATTERS

## Normalization: Some Generalities

<table>
<tr>
<th>SNO</th> <th>SNAME</th> <th>STATUS</th> <th>CITY</th>
</tr>
<tr>
<td>S1</td> <td>Smith</th> </td>20</td>  </td> London</td>
</tr>
</table>

The functional dependency(FD):
    { CITY } -> { STATUS }

Because that FD holds, it turns out that the relvar is in second normal form (2NF) but not third(3NF).

As a consequence, the relver suffers from *redundancy*; to be specific, the fact that a given city has a given status appears many times.

The discipline of *further normalization* would therefore suggest that we decompose the relvar into two relvars `SNC` and `CT` of lesser degree:

SNC:

<table>
<tr>
<th>SNO</th><th>SNAME</th><th>CITY</th>
</tr>
<tr>
<td>S1</td><td>Smith</td><td>London</td>
</tr>
</table>

CT:

<table>
<tr>
<th>CITY</th><th>STATUS</th>
</tr>
<tr>
<td>Athens</td><td>30</td>
<td>London</td><td>20</td>
</tr>

Points arising from this example:

* First, the decomposition certainly eliminates the redundancy -- The fact that a given city has a given status now appears exactly once.
* Second, the decomposition process is basically a process of *taking proiections*

# Normalization

## Background to normalization

### Functional dependency:

In a given table, an attribute Y is said to have a functional dependency on a set of attributes X (Written X -> Y) if and only if each X value is associated with precisely one Y value.

### Normal Forms

The **Normal Form** of relational database theory provide criteria for determining a table's degree of *vulnerability to logicla inconsistencies and anomalies*.

The higher the normal form applicable to a table, the less vulnerable it is.

* **First Normal Form**: No repeating elements or groups of elements.
* **Second Normal Form**: No partial dependencies on a concatenated key.
* **Thrid Normal Form**: No dependencies on non-key attributes.2NF covers the case of multi-column primary keys. 3NF is meant to cover single column keys. Simply stated, pull out columns that don't directly relate to the subject of the row(the primary key), and put them in their own table

## Role-based access control

Approach to restricting system access to authorized users.

Within an organization, roles are created for various job functions. The permissions to perform certain operation are assigned to specific roles.

Since users are not assigned permissions directly, but only acquire them through their role, management of individual user rights becomes a matter of simply assigning appropriate roles to the user's account;

Three primary rules:

1. Role assignment: A subject can exercise a permission only if the subject has selected or been assigned a role.
* Role authorization: A subject's active role must be authorized for the subject. With rule 1 above, this rule ensures that users can take on only roles for which they are authorized.
* Permission is authorized for the subject's active role. With rules 1 and 2, this rule ensures that users can exercise only permissions for which they are authorized.

Conventions:
* S = Subject = A person or automated agent.
* R = Role = Job function or title which defines an authority level.
* P = Permission
* SE = Session = A mapping involving S, R and/or P
* SA = Subject Assignment
* PA = Permission Assignment
* RH = Partially ordered Role Hierarchy. 
