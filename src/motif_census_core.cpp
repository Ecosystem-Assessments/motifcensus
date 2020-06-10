
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix motif_census_uni(LogicalMatrix mat)
{

	if (mat.nrow() != mat.ncol())
	{ // log() not defined here
		stop("`mat` is not square");
	}

	NumericMatrix out(mat.nrow(), 11);
	// 11 unique positions
	// 0-2 => linear chains => 0- bottom 1- medium 2- top
	// 3-4 => apparent competition => 3- bottom 4- top
	// 5-6 => exploitative competition => 5- bottom 6- top
	// 7-9 => omnivory => 7- bottom 8- medium -9 top
	// 10 => circular
	int j, k, i;
	int nsp = mat.nrow();

	// REMOVE bidirectional interactions and cannibalism
	for (i = 0; i < mat.nrow(); i++)
	{
		mat(i, i) = false;
		for (j = i + 1; j < mat.ncol(); j++)
		{
			if (mat(i, j) && mat(j, i))
			{
				mat(i, j) = false;
				mat(j, i) = false;
			}
		}
	}

	// Here starts the part where interactions are checked
	for (i = 0; i < nsp - 2; i++)
	{
		for (j = i + 1; j < nsp - 1; j++)
		{
			for (k = j + 1; k < nsp; k++)
			{
				// there are 27 possibilities
				if (mat(j, i))
				{ // j -> i
					//
					if (mat(k, j))
					{ // k -> j
						if (mat(k, i))
						{
							out(i, 9)++;
							out(j, 8)++;
							out(k, 7)++;
						}
						else if (mat(i, k))
						{
							out(i, 10)++;
							out(j, 10)++;
							out(k, 10)++;
						}
						else
						{
							out(i, 2)++;
							out(j, 1)++;
							out(k, 0)++;
						}
					}
					else if (mat(j, k))
					{ // j -> k
						if (mat(k, i))
						{
							out(i, 9)++;
							out(j, 7)++;
							out(k, 8)++;
						}
						else if (mat(i, k))
						{
							out(i, 8)++;
							out(j, 7)++;
							out(k, 9)++;
						}
						else
						{
							out(i, 6)++;
							out(j, 5)++;
							out(k, 6)++;
						}
					}
					else
					{
						if (mat(k, i))
						{
							out(i, 4)++;
							out(j, 3)++;
							out(k, 3)++;
						}
						else if (mat(i, k))
						{
							out(i, 1)++;
							out(j, 0)++;
							out(k, 2)++;
						}
						else
						{
							// no motif
						}
					}
				}
				else if (mat(i, j))
				{ // i -> j
					//
					if (mat(k, j))
					{
						if (mat(k, i))
						{
							out(i, 8)++;
							out(j, 9)++;
							out(k, 7)++;
						}
						else if (mat(i, k))
						{
							out(i, 7)++;
							out(j, 9)++;
							out(k, 8)++;
						}
						else
						{
							out(i, 3)++;
							out(j, 4)++;
							out(k, 3)++;
						}
					}
					else if (mat(j, k))
					{
						if (mat(k, i))
						{
							out(i, 10)++;
							out(j, 10)++;
							out(k, 10)++;
						}
						else if (mat(i, k))
						{
							out(i, 7)++;
							out(j, 8)++;
							out(k, 9)++;
						}
						else
						{
							out(i, 0)++;
							out(j, 1)++;
							out(k, 2)++;
						}
					}
					else
					{
						if (mat(k, i))
						{
							out(i, 1)++;
							out(j, 2)++;
							out(k, 0)++;
						}
						else if (mat(i, k))
						{
							out(i, 5)++;
							out(j, 6)++;
							out(k, 6)++;
						}
						else
						{
							// no motif
						}
					}
				}
				else
				{
					if (mat(k, j))
					{
						if (mat(k, i))
						{
							out(i, 6)++;
							out(j, 6)++;
							out(k, 5)++;
						}
						else if (mat(i, k))
						{
							out(i, 0)++;
							out(j, 2)++;
							out(k, 1)++;
						}
						else
						{
							// no motif
						}
					}
					else if (mat(j, k))
					{
						if (mat(k, i))
						{
							out(i, 2)++;
							out(j, 0)++;
							out(k, 1)++;
						}
						else if (mat(i, k))
						{
							out(i, 3)++;
							out(j, 3)++;
							out(k, 4)++;
						}
						// no motif otherwise (so else is droped
					}
					// no motif otherwise (so else is droped)
				}
			}
		}
	}
	return out;
}



// [[Rcpp::export]]
NumericMatrix motif_census_bi(LogicalMatrix mat, IntegerMatrix ref)
{

	if (mat.nrow() != mat.ncol())
	{ // log() not defined here
		stop("`mat` is not square");
	}

	// 30 unique positions
	NumericMatrix out(mat.nrow(), 30);
	// NB: ordered following the 13 motifs described in Milo (2002)
	int j, k, i, s, ss;
	int nsp = mat.nrow();

	// REMOVE cannibalism
	for (i = 0; i < mat.nrow(); i++)
		mat(i, i) = false;

	// count motifs
	for (i = 0; i < nsp - 2; i++)
	{
		for (j = i + 1; j < nsp - 1; j++)
		{
			s = mat(i, j) ? 1 : 0;  // i->j
			s += mat(j, i) ? 2 : 0; // j->i
			for (k = j + 1; k < nsp; k++)
			{
				ss = s;
				ss += mat(i, k) ? 4 : 0;  // i->k
				ss += mat(k, i) ? 8 : 0;  // k->i
				ss += mat(j, k) ? 16 : 0; // j->k
				ss += mat(k, j) ? 32 : 0; // k->j
				// if first is different of 0
				if (ref(ss, 0))
				{
					out(i, ref(ss, 0)-1)++;
					out(j, ref(ss, 1)-1)++;
					out(k, ref(ss, 2)-1)++;
				}
			}
		}
	}
	return out;
}