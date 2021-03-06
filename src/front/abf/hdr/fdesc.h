/*
**	Copyright (c) 2004 Ingres Corporation
**	All rights reserved.
*/

/**
** Name:    fdesc.h -		ABF RTS Frame Symbol Table Definitions File.
**
** Description:
**	The symbol table for a frame.  It contains the name, type and
**	size of each variable in a frame (fields, hidden fields, columns,
**	hidden columns)
**
**	NOTE:
**		The structures declared here are also declared in "oslhdr.h",
**		which is in the "ingres/files" directory.  Any changes to these
**		structures in this file must also be reflected in that file
**		preferably through the use of an automatic build facility. Also,
**		some of these structures are built into users' ABF applications,
**		so changes to them have to account for backwards compatibility
**		with the users' applications.  DO NOT change the structures or
**		constants declared here without checking with OSL development.
**
**	ALSO NOTE:
**		These structures are relocated through the use of DS in the
**		ioi library.  DO NOT make any changes here without updating
**		the DS templates used by IOI.
**
** History:
**	Revision 6.3/03/01 
**	02/17/91 (emerson)
**		Made various changes to address bug 35946.
**
**		Bug 35946 resulted from the fact that between 6.3/02 and 6.3/03,
**		two new fields (fdv2_flags and fdv2_typename) were added to the
**		end of the structure FDESCV2. (No entry was placed into this
**		history, but rlog and rcsdiff show they were added on 89/10/20).
**		However, fdsc_version in FDESC was left at 2, and no logic
**		was added to abfrt to handle FDESCV2's created by older
**		compilers.  This especially causes problems for logic that
**		steps through the array of FDESCV2's, since their size changed.
**
**		My fixes for bug 35946 are outlined below.
**
**		(1) In this file (fdesc.h), I have changed FD_VERSION from 2
**		    to 3, so that fdsc_version will get set to 3
**		    in newly created FDESCV2's.
**
**		(2) I created a new constant PR_VERSION defined as 2 in
**		    abfosl.h; it replaces FD_VERSION in cgcall.c and ilcall.sc
**		    (where it was being used for the field pr_version in the
**		    structure ABRTSPRM).
**
**		(3) Also in this file, I have created the structure
**		    FDESCV2_V2, which describes what FDESCV2 is like
**		    when fdsc_version in FDESC is 2.
**
**		    Note: if and when FDESCV2 changes again, the current
**		    FDESCV2 should be copied into a new FDESCV2_V3 structure.
**		    Yes, the names are very confusing.  In hindsight, FDESCV2
**		    was a poor name for the symbol table entry structure;
**		    a better name would have FDESC_ELE, which could have been
**		    renamed to FDESC_ELE_V2 when a version 3 FDESC_ELE needed
**		    to be created.  Note that the version number (FD_VERSION)
**		    placed into fdsc_version in FDESC needs to be bumped
**		    if either FDESC (symbol table header) or FDESCV2 (symbol
**		    table entry) changes.  I chose not to change FDESCV2
**		    to FDESC_ELE because the name shows up in so many places:
**		    in source files in several ABF directories, and in oslhdr.h.
**
**		(4) Background: In C code generated by a 6.0 through 6.3/03/00
**		    OSL compiler, IIARhfiHidFldInit is called early   
**		    in the life of a frame or procedure (before any other
**		    reference to the array of FDESCV2's), unless
**		    the frame or procedure has no fields (visible or hidden).
**		    In an earlier fix for 6.3/03/01 (bug 34840), 
**		    IIARhfiHidFldInit was renamed to IIARhf2HidFldInitV2
**		    throughout ABF, including codegen, and a new
**		    IIARhfiHidFldInit was created, that was simply a cover
**		    for IIARhf2HidFldInitV2 (supplying a default value
**		    for a new third argument).
**
**		    Action: IIARhfiHidFldInit in abrtexpr.c has been changed to:
**		    (a) build an array of FDESCV2's
**			from the old array of FDESCV2_V2's,
**		    (b) make fdsc_ofdesc in the FDESC point to this new array
**			(no other pointers to the array of FDESCV2's exist
**			at that point),
**		    (c) set FDSC_60_6302 bit in the FDESC
**			(this is to help fix bug 35798),
**		    (d) set fdsc_version in the FDESC from 2 to 3,
**		    (e) call IIARhf2HidFldInitV2.
**
**		    To handle the case where a frame or procedure has no fields,
**		    a call to IIARhfiHidFldInit has been added to iiarIObjInit
**		    in the case where fdsc_version is still 2 (since there are
**		    no fields, IIARhf2HidFldInitV2 will do nothing).
**
**		    Steps (a)-(c) are skipped if the frame or procedure
**		    being initialized was compiled under 6.3/03/00.
**		    Since fdsc_version can't be trusted, we have to play
**		    some tricks to determine whether the frame or procedure
**		    was compiled under 6.3/03/00; see abrtexpr.c for details.
**		    Suffice it to say here that the only case where we will
**		    misjudge is the case where the frame or procedure has no
**		    fields and it was compiled under 6.3/03/00: we'll
**		    erroneously conclude that it was compiled under 6.3/02
**		    or earlier.  Since there are no fields, the rebuilt
**		    array of FDESCV2's will be the same as the original array:
**		    a single dummy entry consisting of binary zeroes.
**		    The only harm done is that the FDSC_60_6302 bit will be
**		    erroneously set.
**		
**	Revision 6.0  87/06  arthur
**	Added version 6.0 frame symbol table definition as "FDESCV2".
**	Also, changed 'fdsc_ptr' in OFDESC to be PTR.  (wong)
**
**	Revision 5.1  86/10/17  arthur
**	86/08/14  arthur
**		Changed some "nat"s back to "i4"s.  The structures declared here
**		must remain consistent with those in "~ingres/files/oslhdr.h".
**		Note that "nat"s and "i4"s ARE NOT equivalent on the PC.
**
**	Revision 4.0  85/11  joe
**	85/11/19  10:06:12  joe
**		Added macros to recognize new fdesc and param.
**	85/09/18  17:21:53  john
**		Changed i4=>nat, CVla=>CVna, CVal=>CVan, unsigned char=>u_char
**	85/09/11  13:11:04  joe
**		Integration of work on expressions, argument passing, ....
**
**	Revision 3.0  joe
**	Initial revision.
*/

/*}
** Name:    OFDESC -	ABF RTS Frame Symbol Table Definition, V4.0/5.0.
**
** Description:
**	This structure was used by the ABF runtime system in v4.0/5.0.
**	It is still supported since it exists in the code generated from
**	users' OSL.  The corresponding 'fdsc_version' in the parent
**	FDESC is 1.
**
**	In v3.0, the RTS simply used an array of these structures, then known
**	as FDESCs.
*/
typedef struct
{
    char    *fdsc_name;		/* name of the field or column */
    char    *fdsc_tblname;	/* name of the table field (if any) */
    PTR	    fdsc_ptr;		/* ptr to the local variable for this field */
    char    fdsc_type;		/* type--c, i or f */
    char    fdsc_visible;	/* v if a displayed field, n otherwise */
    i2	    fdsc_order;		/* Order of fields. Valid for procedures only */
    i4	    fdsc_size;		/* length of the field */
} OFDESC;

/*}
** Name:    FDESCV2_V2 - ABF RTS Frame Symbol Table Definition, release 6.0
**
** Description:
**	This structure, new in Ingres 6.0, replaces the OFDESC of v4.0/5.0
**	(in conjunction with the new FDESC structure).
**	Information on type, length and data can now be found in an element
**	of the DB_DATA_VALUE array for the frame.
**	The corresponding 'fdsc_version' in the parent FDESC is 2.
**	This structure was named FDESCV2 until release 6.3.
*/
typedef struct
{
    char	*fdv2_name;	/* name of the field or column */
    char	*fdv2_tblname;	/* name of the table field (if any) */
    char	fdv2_visible;	/* 
				** 'v' if a displayed field.
				** 'h' if a hidden field.
				*/
    i2		fdv2_order;	/* order of flds.  Valid only for procedures */
    i4		fdv2_dbdvoff;	/* offset to DB_DATA_VALUE in array */
} FDESCV2_V2;

/*}
** Name:    FDESCV2 -	ABF RTS Frame Symbol Table Definition, release 6.3
**
** Description:
**	This structure, new in Ingres 6.3, replaces the FDESCV2_V2 of release
**	6.0 through 6.3/02 (where it was named FDESCV2).  FDESCV2 is identical
**	to FDESCV2_V2 except that two new fields (fdv2_flags and fdv2_typename)
**	have been added to the end of the structure, and 'g' is now a valid
**	value for the fdv2_visible field.
**
**	Some info for complex types is stored here, since there's no place for
**	it in the DB_DATA_VALUE for the field.
**
**	The corresponding 'fdsc_version' in the parent FDESC is 3.
**	In C code generated by the 6.3/03/00 OSL compiler, 
**	fdsc_version is erroneously given an initial value of 2 instead of 3.
*/
typedef struct
{
    char	*fdv2_name;	/* name of the field or column */
    char	*fdv2_tblname;	/* name of the table field (if any) */
    char	fdv2_visible;	/* 
				** 'v' if a displayed field.
				** 'h' if a hidden field.
				** 'g' if a global variable or constant.
				*/
    i2		fdv2_order;	/* order of flds.  Valid only for procedures */
    i4		fdv2_dbdvoff;	/* offset to DB_DATA_VALUE in array */
    i2		fdv2_flags;	/* flags: is array, record, local, etc. */
#define	FDF_LOCAL	0x0001	/* local variable, can't be param formal */
#define	FDF_RECORD	0x0002	/* complex datatype */
#define	FDF_ARRAY	0x0004	
#define	FDF_READONLY	0x0008	/* cannot assign to this. */	
#define FDF_MASK	0x00ff	/* so other people can hide flags along with. */

    char	*fdv2_typename;	/* name of the datatype (for complex types) */
} FDESCV2;

/*}
** Name:    FDESC -	ABF RTS Frame Symbol Table Header Definition, V6.0
**
** Description:
**	This structure, new in Ingres 6.0, replaces the OFDESC of v4.0/5.0
**	(in conjunction with the new FDESCV2 structure).
*/
typedef struct
{
    i4	    fdsc_zero;		/* Always zero */
    i4	    fdsc_version;	/* Version number */
# define    FDSC_VERSION    0x00FF  /* Version number proper */
				    /* The following flags are always 0
				    ** if ((fdsc_version & FDSC_VERSION) <= 2).
				    */
# define    FDSC_60_6302    0x0100  /* FDESC and FDESCV2's were generated by
				    ** OSL compiler release 6.0 through 6.3/02
				    ** (or possibly 6.3/03/00, if there
				    ** were no FDESCV2's except the dummy one).
				    */
    i4	    fdsc_cnt;		/* Number of elements */
    OFDESC  *fdsc_ofdesc;	/* Old version of FDESC */
} FDESC;

/*
** Name:    FDESC version number.
**
** In Ingres 3.0, the structure now known as an OFDESC was called an FDESC,
** and the ABF RTS used, simply, an array of those structures.
** In Ingres 4.0/5.0, a new FDESC structure was created, one of whose members
** pointed at the array of OFDESCs.  The 'fdsc_version' was 1.
** In Ingres 6.0, the last member of the FDESC structure actually points
** to an array of FDESCV2_V2s.  The 'fdsc_version' is 2.
** In Ingres 6.3, the last member of the FDESC structure actually points
** to an array of FDESCV2s.  The 'fdsc_version' is 3.
*/
#define	FD_VERSION	3
#define	FD_V2		2
#define	FD_V1		1

/*
** Macro to test for new fdesc structure.
*/
#define	NEWFDESC_MACRO(f)   ((f)->fdsc_zero == 0 && (f)->fdsc_version > 0)

