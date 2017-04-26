include	"mctable.h"


# MCT_INDEF - Fill table buffer with undefined values, acording to the
# data type used.

procedure mct_indef (table, buffer, npts)

pointer	table			# table descriptor
pointer	buffer			# buffer to clear
int	npts			# number of untis to clear

begin
	# Clear according to data type
	switch (MCT_TYPE (table)) {
	case TY_CHAR:
	    call amovkc ('\000', Memc[buffer], npts)
	case TY_SHORT:
	    call amovks (INDEFS, Mems[buffer], npts)
	case TY_INT:
	    call amovki (INDEFI, Memi[buffer], npts)
	case TY_LONG:
	    call amovkl (INDEFL, Meml[buffer], npts)
	case TY_REAL:
	    call amovkr (INDEFR, Memr[buffer], npts)
	case TY_DOUBLE:
	    call amovkd (INDEFD, Memd[buffer], npts)
	case TY_COMPLEX:
	    call amovkx (INDEFX, Memx[buffer], npts)
	case TY_POINTER:
	    call amovki (NULL, Memi[buffer], npts)
	default:
	    call error (0, "mct_indef: Unknown data type")
	}
end
