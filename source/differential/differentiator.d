//=============================================================================
// Copyright (c) 2017 Ryooooooga
// https://github.com/Ryooooooga
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom
// the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//=============================================================================

module differential.differentiator;

import std.algorithm;
import differential.expressions;
import differential.visitor;

class Differentiator
{
	mixin Visitor;

	Expression differentiate(Expression f, string x)
	{
		return this.dispatch!"visit"(f, x);
	}

	private Expression visit(Constant f, string x)
	{
		return new Constant(0);
	}

	private Expression visit(Variable f, string x)
	{
		if (f.name == x)
		{
			return new Constant(1);
		}

		return f;
	}

	private Expression visit(Addition f, string x)
	{
		return new Addition(
			this.differentiate(f.left, x),
			this.differentiate(f.right, x),
		);
	}

	private Expression visit(Multiplication f, string x)
	{
		return new Addition(
			new Multiplication(this.differentiate(f.left, x), f.right),
			new Multiplication(f.left, this.differentiate(f.right, x)),
		);
	}

	private Expression visit(Sine f, string x)
	{
		return new Multiplication(
			this.differentiate(f.child, x),
			new Cosine(f.child),
		);
	}

	private Expression visit(Cosine f, string x)
	{
		return new Multiplication(
			this.differentiate(f.child, x),
			new Multiplication(new Constant(-1), new Sine(f.child)),
		);
	}

	private Expression visit(Exponent f, string x)
	{
		return new Multiplication(f, new Addition(
			new Multiplication(this.differentiate(f.exponent, x), new Log(f.base)),
			new Multiplication(new Multiplication(this.differentiate(f.base, x), f.exponent), new Exponent(f.base, new Constant(-1))),
		));
	}

	private Expression visit(Log f, string x)
	{
		return new Multiplication(
			this.differentiate(f.child, x),
			new Exponent(f.child, new Constant(-1)),
		);
	}
}
