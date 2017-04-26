include	"mctable.h"


# MCT_COPY - Copy one table into another. The destination table is allocated
# or reallocated if necessary.

procedure mct_copy (itable, otable)

pointer	itable			# input table descriptor
pointer	otable			# output table descriptor

int	isize, osize		# table sizes

errchk	mct_alloc()

begin
	# Check input pointer and magic number
	if (itable == NULL)
	    call error (0, "mct_copy: Null input table pointer")
	if (MCT_MAGIC (itable) != MAGIC)
	    call error (0, "mct_copy: Bad input magic number")

	# Compute input table size
	isize = MCT_MAXROW (itable) * MCT_MAXCOL (itable)

	# Check output pointer. Try to minimize space allocation.
	if (otable == NULL)
	    call mct_alloc (otable, MCT_MAXROW (itable), MCT_MAXCOL (itable),
			    MCT_TYPE (itable))
	else if (MCT_MAGIC (otable) == MAGIC) {
	    osize = MCT_MAXROW (otable) * MCT_MAXCOL (otable)
	    if (isize != osize || MCT_TYPE (itable) != MCT_TYPE (otable))
	        call realloc (MCT_DATA (otable), isize, MCT_TYPE (itable))
	} else
	    call error (0, "mct_copy: Bad output magic number")
	
	# Copy structure
	MCT_MAGIC (otable)   = MCT_MAGIC (itable)
	MCT_TYPE (otable)    = MCT_TYPE (itable)
	MCT_MAXROW (otable)  = MCT_MAXROW (itable)
	MCT_MAXCOL (otable)  = MCT_MAXCOL (itable)
	MCT_INCROWS (otable) = MCT_INCROWS (itable)
	MCT_NPROWS (otable)  = MCT_NPROWS (itable)
	MCT_NPCOLS (otable)  = MCT_NPCOLS (itable)
	MCT_NGROWS (otable)  = MCT_NGROWS (itable)
	MCT_NGCOLS (otable)  = MCT_NGCOLS (itable)

	# Copy data buffer
	switch (MCT_TYPE (otable)) {

	case TY_CHAR:
	    call amovc (Memc[MCT_DATA (itable)], Memc[MCT_DATA (otable)], isize)

	case TY_SHORT:
	    call amovs (Mems[MCT_DATA (itable)], Mems[MCT_DATA (otable)], isize)

	case TY_INT:
	    call amovi (Memi[MCT_DATA (itable)], Memi[MCT_DATA (otable)], isize)

	case TY_LONG:
	    call amovl (Meml[MCT_DATA (itable)], Meml[MCT_DATA (otable)], isize)

	case TY_REAL:
	    call amovr (Memr[MCT_DATA (itable)], Memr[MCT_DATA (otable)], isize)

	case TY_DOUBLE:
	    call amovd (Memd[MCT_DATA (itable)], Memd[MCT_DATA (otable)], isize)

	case TY_COMPLEX:
	    call amovx (Memx[MCT_DATA (itable)], Memx[MCT_DATA (otable)], isize)

	case TY_POINTER:
	    call amovi (Memi[MCT_DATA (itable)], Memi[MCT_DATA (otable)], isize)

	default:
	    call error (0, "mct_copy: Unknown table type")
	}
end
