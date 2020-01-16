
#include <Rcpp.h>
using namespace Rcpp;


//' @name motif_census
//'
//' @title Compute motif census for a directional network.
//'
//' @description
//' Count motifs and positions within motifs for a directional network.
//'
//' @param mat a square matrix of logical describing a directional network.
//'
//' @export
//'
//' @return
//' A dataframe with species as rows and motifs as columns, motif positions are ordered as follows:
//'	* 1 linear chains bottom;
//'	* 2 linear chains middle;
//'	* 3 linear chains top;
//'	* 4 apparent competition botton;
//'	* 5 apparent competition top;
//'	* 6 exploitative competition bottom;
//'	* 7 exploitative competition top;
//'	* 8 omnivory bottom;
//'	* 9 omnivory middle;
//'	* 10 omnivory top;
//'	* 11 circular (e.g. 1->2->3->1).

// [[Rcpp::export]]
NumericMatrix motif_census(LogicalMatrix mat)
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
						else
						{
							// no motif
						}
					}
					else
					{
						// no motif
					}
				}
			}
		}
	}

	return out;
}

//' @name motif_census_bidirectional
//'
//' @title Compute motif census for a bidirectional network.
//'
//' @description
//' Count motifs and positions within motifs for a bidirectional network.
//'
//' @param mat a square matrix of logical describing a directional network.
//'
//' @references
//' Milo, R. (2002). Network Motifs: Simple Building Blocks of Complex Networks. Science, 298(5594), 824–827. https://doi.org/10.1126/science.298.5594.824
//'
//' @export
//'
// [[Rcpp::export]]
NumericMatrix motif_census_bidirectional(LogicalMatrix mat)
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
				Rcout << ss << std::endl;
				// here big swith case here
				switch (ss)
				{
				// **motif 1** expoitative competition, 3 cases
				// 2 positions -- bottom (2): 0 and top (1): 1
				case 5:
				{
					out(i, 1)++;
					out(j, 0)++;
					out(k, 0)++;
					break;
				}
				case 18:
				{
					out(j, 1)++;
					out(i, 0)++;
					out(k, 0)++;
					break;
				}
				case 40:
				{
					out(k, 1)++;
					out(i, 0)++;
					out(j, 0)++;
					break;
				}
				// **motif 2** linear chain, 6 cases
				// 3 positions -- bottom: 2, middle: 3 and top: 4
				case 6: // j->i->k
				{
					out(i, 3)++;
					out(j, 2)++;
					out(k, 4)++;
					break;
				}
				case 9: // k->i->j
				{
					out(i, 3)++;
					out(j, 4)++;
					out(k, 2)++;
					break;
				}
				case 17: // i->j->k
				{
					out(i, 2)++;
					out(j, 3)++;
					out(k, 4)++;
					break;
				}
				case 24: // j->k->i
				{
					out(i, 4)++;
					out(j, 2)++;
					out(k, 3)++;
					break;
				}
				case 34: // k->j->i
				{
					out(i, 4)++;
					out(j, 3)++;
					out(k, 2)++;
					break;
				}
				case 36: // i->k->j
				{
					out(i, 2)++;
					out(j, 4)++;
					out(k, 3)++;
					break;
				}
				// **motif 3** A->B->C + B->A, 6 cases
				// 3 positions -- bottom: 5, middle: 6 and top: 7
				case 7: // j->i->k + i->j
				{
					out(i, 6)++;
					out(j, 5)++;
					out(k, 7)++;
					break;
				}
				case 13: // k->i->j + i->k
				{
					out(i, 6)++;
					out(j, 7)++;
					out(k, 5)++;
					break;
				}
				case 19: // i->j->k + j->i
				{
					out(i, 5)++;
					out(j, 6)++;
					out(k, 7)++;
					break;
				}
				case 56: // j->k->i + k->j
				{
					out(i, 7)++;
					out(j, 5)++;
					out(k, 6)++;
					break;
				}
				case 50: // k->j->i + j->k
				{
					out(i, 7)++;
					out(j, 6)++;
					out(k, 5)++;
					break;
				}
				case 44: // i->k->j + k->i
				{
					out(i, 5)++;
					out(j, 7)++;
					out(k, 6)++;
				}
				// **motif 5** circluar, 2cases
				// 1 position -- unique 11
				case 25:
				case 38:
				{
					out(i, 11)++;
					out(j, 11)++;
					out(k, 11)++;
					break;
				}
				// **motif 13** fully connected, 1 case
				// position: 29
				case 63:
				{
					out(i, 29)++;
					out(j, 29)++;
					out(k, 29)++;
					break;
				}
				}
			}
		}
	}
	return out;
}