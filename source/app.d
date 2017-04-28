import std.stdio;
import differential.expressions;
import differential.differentiator;
import differential.optimizer;
import differential.tex_printer;

void main()
{
	// 1/tan(x)
	auto expr = new Multiplication(
		new Cosine(new Variable("x")),
		new Exponent(new Sine(new Variable("x")), new Constant(-1)));

	// dy/dx
	auto diff = new Differentiator().differentiate(expr, "x");

	new TexPrinter(stdout).print(new Optimizer().optimize(diff));
}
