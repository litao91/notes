High Level Structure
====================

Main components:

* User interface
* The browser engine - interface for querying and manipulating the
  rendering engine
* The rendering engine - the interface for querying the requested content.
  Parsing HTML and CSS and displaying the parsed item on the screen.
* Networking - used for network calls. 
* UI backend.
* JS interpreter
* Data storage. 

The main flow
=============

1. Parsing HTML to construct DOM tree (content tree -> :)
* Render tree construction
* Layout of the render tree
* Painting the render tree


The tokenization algorithm

The algorithm's output is an HTML token. The algorithm is expressed as a
state machine.

* Each state consumes one or more characters of the input stream and
  updates the next state according to those characters. 
* Decision is influenced by the current tokenization state and by the tree
  construction state. -> the same consumed character will yield different
  results for the correct next state, depending on the current state.

Example: 

    <html>
        <body>
            Hello World
        </body>
    </html>

* Initial state is Data State
* When see the '<', the state is changed to **Tage open state**
* Consuming an "a-z" character causes creation of a "Start tage toekn",
  the state is changed to **Tag name state**
* Stay in this state until the ">" is encountered. Each character is
  appended to the new token name. 
* When the ">" is reached, the current token is emitted and the state
  changes back to **Data steate**.
* Same process for &lt;body&gt; tag
* Consuming the "H" will cause creation and emitting of a character token.
* This goes on until the "<" of "&lt;/body&gt;" is reached
* The consuming the next input "/" will cause creation of "end tag token"
  and move tot he "**Tag name state**". Stay in this state until we reach
  ">"

Tree construction algorithm
===========================
