/* This is a grammar written to be compiled by PEG.js, this is the most human readable form of the parser */

/* Here are our tokens that get spit out by our parser, then all combined once the "start" rule finishes */

{
  function TokenList(tokens) {
    this.getValue = function() {
      var tokenListResult = 0;

      for (var i = 0; i < tokens.length; i++) {
        tokenListResult += tokens[i].getValue()
      }

      return tokenListResult;
    }
  }
  function AdditiveToken(valueToken) {
    this.getValue = function() {
      return valueToken.getValue();
    }
  }
  function SubtractiveToken(valueToken) {
    this.getValue = function() {
      return -1 * valueToken.getValue();
    }
  }
  function RollToken(countToken, sizeToken) {
    this.getValue = function() {
      //Figure out how many times we are rolling, and what size die to use.
      var count = countToken.getValue();
      var size = sizeToken.getValue();

      var rollResult = 0;

      for (var i = 0; i < count; i++) {
        rollResult += Math.ceil(Math.random() * size);
      }

      return rollResult;
    }
  }
  function NumberToken(num) {
    this.getValue = function() {
      return num;
    }
  }
}

/* Here is the grammar itself, what defines all the work that gets done parsing the input */

start
= tokens:tokenList { return tokens.getValue() }

tokenList
= roll:dieRoll mod:modifier* {return new TokenList([roll, new TokenList(mod)]) }

modifier
= additive
/ subtractive

additive
= "+" number:number { return new AdditiveToken(number) }

subtractive
= "-" number:number { return new SubtractiveToken(number) }

number
= dieRoll
/ integer

dieRoll
= count:integer "d" size:integer { return new RollToken(count, size) }

integer "integer"
= digits:[0-9]+ { return new NumberToken(parseInt(digits.join(""), 10)); }
