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

module differential.tex_printer;

import std.stdio;
import differential.expressions;
import differential.visitor;

class TexPrinter
{
	mixin Visitor;

	private File _file;

	this(File file)
	{
		this._file = file;
	}

	void print(Expression node)
	{
		this.dispatch!"visit"(node);
	}

	private void visit(Constant f)
	{
		this._file.write("(");
		this._file.write(f.value);
		this._file.write(")");
	}

	private void visit(Variable f)
	{
		this._file.write(f.name);
	}

	private void visit(Addition f)
	{
		this._file.write("(");
		this.print(f.left);
		this._file.write("+");
		this.print(f.right);
		this._file.write(")");
	}

	private void visit(Multiplication f)
	{
		this._file.write("(");
		this.print(f.left);
		this._file.write("*");
		this.print(f.right);
		this._file.write(")");
	}

	private void visit(Sine f)
	{
		this._file.write("sin(");
		this.print(f.child);
		this._file.write(")");
	}

	private void visit(Cosine f)
	{
		this._file.write("cos(");
		this.print(f.child);
		this._file.write(")");
	}

	private void visit(Exponent f)
	{
		this.print(f.base);
		this._file.write("^{");
		this.print(f.exponent);
		this._file.write("}");
	}

	private void visit(Log f)
	{
		this._file.write("ln(");
		this.print(f.child);
		this._file.write(")");
	}
}
