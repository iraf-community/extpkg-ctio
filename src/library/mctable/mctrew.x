include	"mctable.h"


# MCT_REW - Rewing sequential get counters.

procedure mct_rew (table)

pointer	table			# table descriptor

begin
	# Check pointer and magic number
	if (table == NULL)
	    call error (0, "mct_seqrew: Null table pointer")
	if (MCT_MAGIC (table) != MAGIC)
	    call error (0, "mct_seqrew: Bad magic number")

	# Clear get counters
	MCT_NGCOLS (table) = 0
	MCT_NGROWS (table) = 0
end
