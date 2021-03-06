include	"mctable.h"


# MCT_GET - Get a single value from the table (generic)

complex procedure mct_getx (table, row, col)

pointer	table			# table descriptor
int	row			# row number
int	col			# column number

pointer	mct_getrow()

errchk	mct_getrow()

begin
	# Check pointer and magic number
	if (table == NULL)
	    call error (0, "mct_get: Null table pointer")
	if (MCT_MAGIC (table) != MAGIC)
	    call error (0, "mct_get: Bad magic number")

	# Check table type
	if (MCT_TYPE (table) != TY_COMPLEX)
	    call error (0, "mct_get: Wrong table type")

	# Check row, and column range
	if (row < 1 || row > MCT_NPROWS (table))
	    call error (0, "mct_get: Bad row number")
	if (row == MCT_NPROWS (table) && (col < 1 || col > MCT_NPCOLS (table)))
	    call error (0, "mct_get: Bad column number at last row")
	if (row != MCT_NPROWS (table) && (col < 1 || col > MCT_MAXCOL (table)))
	    call error (0, "mct_get: Bad column number")

	# Update get counters
	MCT_NGROWS (table) = row
	MCT_NGCOLS (table) = col

	# Return value
	return (Memx[mct_getrow (table, row) + col - 1])
end
