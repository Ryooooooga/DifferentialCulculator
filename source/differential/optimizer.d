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

module differential.optimizer;

import std.typecons;
import differential.expressions;
import differential.visitor;

/**
 * @brief      Expression optimizer.
 */
class Optimizer
{
	mixin Visitor;

	Expression optimize(Expression f)
	{
		return this.dispatch!"visit"(f);
	}

	private Expression visit(Constant f)
	{
		return f;
	}

	private Expression visit(Variable f)
	{
		return f;
	}

	private Expression visit(Addition f)
	{
		auto left  = this.optimize(f.left);
		auto right = this.optimize(f.right);

		auto l = this.dispatch!"constant"(left);
		auto r = this.dispatch!"constant"(right);

		if (!l.isNull && l == 0)
		{
			return right;
		}
		if (!r.isNull && r == 0)
		{
			return left;
		}

		return new Addition(left, right);
	}

	private Expression visit(Multiplication f)
	{
		auto left  = this.optimize(f.left);
		auto right = this.optimize(f.right);

		auto l = this.dispatch!"constant"(left);
		auto r = this.dispatch!"constant"(right);

		if ((!l.isNull && l == 0) || (!r.isNull && r == 0))
		{
			return new Constant(0);
		}
		if (!l.isNull && l == 1)
		{
			return right;
		}
		if (!r.isNull && r == 1)
		{
			return left;
		}

		return new Multiplication(left, right);
	}

	private Expression visit(Sine f)
	{
		return new Sine(this.optimize(f.child));
	}

	private Expression visit(Cosine f)
	{
		return new Cosine(this.optimize(f.child));
	}

	private Expression visit(Exponent f)
	{
		return new Exponent(this.optimize(f.base), this.optimize(f.exponent));
	}

	private Expression visit(Log f)
	{
		return new Log(this.optimize(f.child));
	}

	private Nullable!double constant(Expression f)
	{
		return Nullable!double.init;
	}

	private Nullable!double constant(Constant f)
	{
		return f.value.nullable;
	}
}
