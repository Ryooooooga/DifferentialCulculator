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

module differential.expressions;

/**
 * @brief      Expression base.
 */
class Expression
{
}

/**
 * @brief      Constant expression.
 */
class Constant: Expression
{
	private double _value;

	this(double value)
	{
		this._value = value;
	}

	double value() const 
	{
		return this._value;
	}
}

/**
 * @brief      Variable.
 */
class Variable: Expression
{
	private string _name;

	this(string name)
	{
		this._name = name;
	}

	string name() const
	{
		return this._name;
	}
}

/**
 * @brief      `f + g`.
 */
class Addition: Expression
{
	private Expression _lhs;
	private Expression _rhs;

	this(Expression lhs, Expression rhs)
	{
		this._lhs = lhs;
		this._rhs = rhs;
	}

	Expression left()
	{
		return this._lhs;
	}

	Expression right()
	{
		return this._rhs;
	}
}

/**
 * @brief      `f * g`.
 */
class Multiplication: Expression
{
	private Expression _lhs;
	private Expression _rhs;

	this(Expression lhs, Expression rhs)
	{
		this._lhs = lhs;
		this._rhs = rhs;
	}

	Expression left()
	{
		return this._lhs;
	}

	Expression right()
	{
		return this._rhs;
	}
}

/**
 * @brief      `sin(f)`.
 */
class Sine: Expression
{
	private Expression _child;

	this(Expression child)
	{
		this._child = child;
	}

	Expression child()
	{
		return this._child;
	}
}

/**
 * @brief      `cos(f)`.
 */
class Cosine: Expression
{
	private Expression _child;

	this(Expression child)
	{
		this._child = child;
	}

	Expression child()
	{
		return this._child;
	}
}

/**
 * @brief      `f ^ g`.
 */
class Exponent: Expression
{
	private Expression _base;
	private Expression _exponent;

	this(Expression base, Expression exponent)
	{
		this._base     = base;
		this._exponent = exponent;
	}

	Expression base()
	{
		return this._base;
	}

	Expression exponent()
	{
		return this._exponent;
	}
}

/**
 * @brief      `ln(f)`.
 */
class Log: Expression
{
	private Expression _child;

	this(Expression child)
	{
		this._child = child;
	}

	Expression child()
	{
		return this._child;
	}
}
