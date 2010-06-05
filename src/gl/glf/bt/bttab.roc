/*
**Copyright (c) 2004 Ingres Corporation
*/

# include	<compat.h>
# include	<gl.h>

/*
** Name:	bttabs.roc
**
** Description:
**		Tables for fast bt routines.  These are all constants.
**		Implementation requires 8 bit bytes.
**
LIBRARY = IMPCOMPATLIBDATA
** History:
**      
**      20-jul-87 (mmm)
**          Updated to meet jupiter coding standards.      
**	22-nov-89 (swm)
**	    For u_char values initialised as ~n (where n is a literal value)
**	    had to cast the initialisation within the bt_clrmsk structure to
**	    get it to compile.
**	09-may-90 (blaise)
**	    Integrated ingresug changes into 63p lib.
**	15-jul-93 (ed)
**	    adding <gl.h> after <compat.h>
**	14-sep-1995 (sweeney)
**	    purge WECOV, VAX defines, elide useless RCS history.
*/

/* masks to extract a specified bit from a byte */

GLOBALDEF u_char bt_bitmsk[] =
{
	/* 0 */		1 << 0,
	/* 1 */		1 << 1,
	/* 2 */		1 << 2,
	/* 3 */		1 << 3,
	/* 4 */		1 << 4,
	/* 5 */		1 << 5,
	/* 6 */		1 << 6,
	/* 7 */		1 << 7
};

/*
** masks to clear a specified bit from a byte 
*/

GLOBALDEF u_char bt_clrmsk[] =
{
	/* 0 */		(u_char)~(1 << 0),
	/* 1 */		(u_char)~(1 << 1),
	/* 2 */		(u_char)~(1 << 2),
	/* 3 */		(u_char)~(1 << 3),
	/* 4 */		(u_char)~(1 << 4),
	/* 5 */		(u_char)~(1 << 5),
	/* 6 */		(u_char)~(1 << 6),
	/* 7 */		(u_char)~(1 << 7)
};

/* 
** masks to skip the index number of low order bits.
*/

GLOBALDEF u_char bt_highmsk[] =
{
	/* 0 */		0xff,
	/* 1 */		0xfe,
	/* 2 */		0xfc,
	/* 3 */		0xf8,
	/* 4 */		0xf0,
	/* 5 */		0xe0,
	/* 6 */		0xc0,
	/* 7 */		0x80,
	/* 8 */		0x00,
};

/*
** masks to skip all but the index number of low order bits
*/

GLOBALDEF u_char bt_lowmsk[] =
{
	/* 0 */		0x00,
	/* 1 */		0x01,
	/* 2 */		0x03,
	/* 3 */		0x07,
	/* 4 */		0x0f,
	/* 5 */		0x1f,
	/* 6 */		0x3f,
	/* 7 */		0x7f,
	/* 8 */		0xff,
};

/*
**  Table to find last set bit 
*/

GLOBALDEF u_char bt_flstab [] =
{
	/*   0 */	127,
	/*   1 */	0,
	/*   2 */	1,
	/*   3 */	1,
	/*   4 */	2,
	/*   5 */	2,
	/*   6 */	2,
	/*   7 */	2,
	/*   8 */	3,
	/*   9 */	3,
	/*  10 */	3,
	/*  11 */	3,
	/*  12 */	3,
	/*  13 */	3,
	/*  14 */	3,
	/*  15 */	3,
	/*  16 */	4,
	/*  17 */	4,
	/*  18 */	4,
	/*  19 */	4,
	/*  20 */	4,
	/*  21 */	4,
	/*  22 */	4,
	/*  23 */	4,
	/*  24 */	4,
	/*  25 */	4,
	/*  26 */	4,
	/*  27 */	4,
	/*  28 */	4,
	/*  29 */	4,
	/*  30 */	4,
	/*  31 */	4,
	/*  32 */	5,
	/*  33 */	5,
	/*  34 */	5,
	/*  35 */	5,
	/*  36 */	5,
	/*  37 */	5,
	/*  38 */	5,
	/*  39 */	5,
	/*  40 */	5,
	/*  41 */	5,
	/*  42 */	5,
	/*  43 */	5,
	/*  44 */	5,
	/*  45 */	5,
	/*  46 */	5,
	/*  47 */	5,
	/*  48 */	5,
	/*  49 */	5,
	/*  50 */	5,
	/*  51 */	5,
	/*  52 */	5,
	/*  53 */	5,
	/*  54 */	5,
	/*  55 */	5,
	/*  56 */	5,
	/*  57 */	5,
	/*  58 */	5,
	/*  59 */	5,
	/*  60 */	5,
	/*  61 */	5,
	/*  62 */	5,
	/*  63 */	5,
	/*  64 */	6,
	/*  65 */	6,
	/*  66 */	6,
	/*  67 */	6,
	/*  68 */	6,
	/*  69 */	6,
	/*  70 */	6,
	/*  71 */	6,
	/*  72 */	6,
	/*  73 */	6,
	/*  74 */	6,
	/*  75 */	6,
	/*  76 */	6,
	/*  77 */	6,
	/*  78 */	6,
	/*  79 */	6,
	/*  80 */	6,
	/*  81 */	6,
	/*  82 */	6,
	/*  83 */	6,
	/*  84 */	6,
	/*  85 */	6,
	/*  86 */	6,
	/*  87 */	6,
	/*  88 */	6,
	/*  89 */	6,
	/*  90 */	6,
	/*  91 */	6,
	/*  92 */	6,
	/*  93 */	6,
	/*  94 */	6,
	/*  95 */	6,
	/*  96 */	6,
	/*  97 */	6,
	/*  98 */	6,
	/*  99 */	6,
	/* 100 */	6,
	/* 101 */	6,
	/* 102 */	6,
	/* 103 */	6,
	/* 104 */	6,
	/* 105 */	6,
	/* 106 */	6,
	/* 107 */	6,
	/* 108 */	6,
	/* 109 */	6,
	/* 110 */	6,
	/* 111 */	6,
	/* 112 */	6,
	/* 113 */	6,
	/* 114 */	6,
	/* 115 */	6,
	/* 116 */	6,
	/* 117 */	6,
	/* 118 */	6,
	/* 119 */	6,
	/* 120 */	6,
	/* 121 */	6,
	/* 122 */	6,
	/* 123 */	6,
	/* 124 */	6,
	/* 125 */	6,
	/* 126 */	6,
	/* 127 */	6,
	/* 128 */	7,
	/* 129 */	7,
	/* 130 */	7,
	/* 131 */	7,
	/* 132 */	7,
	/* 133 */	7,
	/* 134 */	7,
	/* 135 */	7,
	/* 136 */	7,
	/* 137 */	7,
	/* 138 */	7,
	/* 139 */	7,
	/* 140 */	7,
	/* 141 */	7,
	/* 142 */	7,
	/* 143 */	7,
	/* 144 */	7,
	/* 145 */	7,
	/* 146 */	7,
	/* 147 */	7,
	/* 148 */	7,
	/* 149 */	7,
	/* 150 */	7,
	/* 151 */	7,
	/* 152 */	7,
	/* 153 */	7,
	/* 154 */	7,
	/* 155 */	7,
	/* 156 */	7,
	/* 157 */	7,
	/* 158 */	7,
	/* 159 */	7,
	/* 160 */	7,
	/* 161 */	7,
	/* 162 */	7,
	/* 163 */	7,
	/* 164 */	7,
	/* 165 */	7,
	/* 166 */	7,
	/* 167 */	7,
	/* 168 */	7,
	/* 169 */	7,
	/* 170 */	7,
	/* 171 */	7,
	/* 172 */	7,
	/* 173 */	7,
	/* 174 */	7,
	/* 175 */	7,
	/* 176 */	7,
	/* 177 */	7,
	/* 178 */	7,
	/* 179 */	7,
	/* 180 */	7,
	/* 181 */	7,
	/* 182 */	7,
	/* 183 */	7,
	/* 184 */	7,
	/* 185 */	7,
	/* 186 */	7,
	/* 187 */	7,
	/* 188 */	7,
	/* 189 */	7,
	/* 190 */	7,
	/* 191 */	7,
	/* 192 */	7,
	/* 193 */	7,
	/* 194 */	7,
	/* 195 */	7,
	/* 196 */	7,
	/* 197 */	7,
	/* 198 */	7,
	/* 199 */	7,
	/* 200 */	7,
	/* 201 */	7,
	/* 202 */	7,
	/* 203 */	7,
	/* 204 */	7,
	/* 205 */	7,
	/* 206 */	7,
	/* 207 */	7,
	/* 208 */	7,
	/* 209 */	7,
	/* 210 */	7,
	/* 211 */	7,
	/* 212 */	7,
	/* 213 */	7,
	/* 214 */	7,
	/* 215 */	7,
	/* 216 */	7,
	/* 217 */	7,
	/* 218 */	7,
	/* 219 */	7,
	/* 220 */	7,
	/* 221 */	7,
	/* 222 */	7,
	/* 223 */	7,
	/* 224 */	7,
	/* 225 */	7,
	/* 226 */	7,
	/* 227 */	7,
	/* 228 */	7,
	/* 229 */	7,
	/* 230 */	7,
	/* 231 */	7,
	/* 232 */	7,
	/* 233 */	7,
	/* 234 */	7,
	/* 235 */	7,
	/* 236 */	7,
	/* 237 */	7,
	/* 238 */	7,
	/* 239 */	7,
	/* 240 */	7,
	/* 241 */	7,
	/* 242 */	7,
	/* 243 */	7,
	/* 244 */	7,
	/* 245 */	7,
	/* 246 */	7,
	/* 247 */	7,
	/* 248 */	7,
	/* 249 */	7,
	/* 250 */	7,
	/* 251 */	7,
	/* 252 */	7,
	/* 253 */	7,
	/* 254 */	7,
	/* 255 */	7
};

/*
** Table to find first set bit 
*/

GLOBALDEF u_char bt_ffstab [] =
{
	/*   0 */	127,
	/*   1 */	0,
	/*   2 */	1,
	/*   3 */	0,
	/*   4 */	2,
	/*   5 */	0,
	/*   6 */	1,
	/*   7 */	0,
	/*   8 */	3,
	/*   9 */	0,
	/*  10 */	1,
	/*  11 */	0,
	/*  12 */	2,
	/*  13 */	0,
	/*  14 */	1,
	/*  15 */	0,
	/*  16 */	4,
	/*  17 */	0,
	/*  18 */	1,
	/*  19 */	0,
	/*  20 */	2,
	/*  21 */	0,
	/*  22 */	1,
	/*  23 */	0,
	/*  24 */	3,
	/*  25 */	0,
	/*  26 */	1,
	/*  27 */	0,
	/*  28 */	2,
	/*  29 */	0,
	/*  30 */	1,
	/*  31 */	0,
	/*  32 */	5,
	/*  33 */	0,
	/*  34 */	1,
	/*  35 */	0,
	/*  36 */	2,
	/*  37 */	0,
	/*  38 */	1,
	/*  39 */	0,
	/*  40 */	3,
	/*  41 */	0,
	/*  42 */	1,
	/*  43 */	0,
	/*  44 */	2,
	/*  45 */	0,
	/*  46 */	1,
	/*  47 */	0,
	/*  48 */	4,
	/*  49 */	0,
	/*  50 */	1,
	/*  51 */	0,
	/*  52 */	2,
	/*  53 */	0,
	/*  54 */	1,
	/*  55 */	0,
	/*  56 */	3,
	/*  57 */	0,
	/*  58 */	1,
	/*  59 */	0,
	/*  60 */	2,
	/*  61 */	0,
	/*  62 */	1,
	/*  63 */	0,
	/*  64 */	6,
	/*  65 */	0,
	/*  66 */	1,
	/*  67 */	0,
	/*  68 */	2,
	/*  69 */	0,
	/*  70 */	1,
	/*  71 */	0,
	/*  72 */	3,
	/*  73 */	0,
	/*  74 */	1,
	/*  75 */	0,
	/*  76 */	2,
	/*  77 */	0,
	/*  78 */	1,
	/*  79 */	0,
	/*  80 */	4,
	/*  81 */	0,
	/*  82 */	1,
	/*  83 */	0,
	/*  84 */	2,
	/*  85 */	0,
	/*  86 */	1,
	/*  87 */	0,
	/*  88 */	3,
	/*  89 */	0,
	/*  90 */	1,
	/*  91 */	0,
	/*  92 */	2,
	/*  93 */	0,
	/*  94 */	1,
	/*  95 */	0,
	/*  96 */	5,
	/*  97 */	0,
	/*  98 */	1,
	/*  99 */	0,
	/* 100 */	2,
	/* 101 */	0,
	/* 102 */	1,
	/* 103 */	0,
	/* 104 */	3,
	/* 105 */	0,
	/* 106 */	1,
	/* 107 */	0,
	/* 108 */	2,
	/* 109 */	0,
	/* 110 */	1,
	/* 111 */	0,
	/* 112 */	4,
	/* 113 */	0,
	/* 114 */	1,
	/* 115 */	0,
	/* 116 */	2,
	/* 117 */	0,
	/* 118 */	1,
	/* 119 */	0,
	/* 120 */	3,
	/* 121 */	0,
	/* 122 */	1,
	/* 123 */	0,
	/* 124 */	2,
	/* 125 */	0,
	/* 126 */	1,
	/* 127 */	0,
	/* 128 */	7,
	/* 129 */	0,
	/* 130 */	1,
	/* 131 */	0,
	/* 132 */	2,
	/* 133 */	0,
	/* 134 */	1,
	/* 135 */	0,
	/* 136 */	3,
	/* 137 */	0,
	/* 138 */	1,
	/* 139 */	0,
	/* 140 */	2,
	/* 141 */	0,
	/* 142 */	1,
	/* 143 */	0,
	/* 144 */	4,
	/* 145 */	0,
	/* 146 */	1,
	/* 147 */	0,
	/* 148 */	2,
	/* 149 */	0,
	/* 150 */	1,
	/* 151 */	0,
	/* 152 */	3,
	/* 153 */	0,
	/* 154 */	1,
	/* 155 */	0,
	/* 156 */	2,
	/* 157 */	0,
	/* 158 */	1,
	/* 159 */	0,
	/* 160 */	5,
	/* 161 */	0,
	/* 162 */	1,
	/* 163 */	0,
	/* 164 */	2,
	/* 165 */	0,
	/* 166 */	1,
	/* 167 */	0,
	/* 168 */	3,
	/* 169 */	0,
	/* 170 */	1,
	/* 171 */	0,
	/* 172 */	2,
	/* 173 */	0,
	/* 174 */	1,
	/* 175 */	0,
	/* 176 */	4,
	/* 177 */	0,
	/* 178 */	1,
	/* 179 */	0,
	/* 180 */	2,
	/* 181 */	0,
	/* 182 */	1,
	/* 183 */	0,
	/* 184 */	3,
	/* 185 */	0,
	/* 186 */	1,
	/* 187 */	0,
	/* 188 */	2,
	/* 189 */	0,
	/* 190 */	1,
	/* 191 */	0,
	/* 192 */	6,
	/* 193 */	0,
	/* 194 */	1,
	/* 195 */	0,
	/* 196 */	2,
	/* 197 */	0,
	/* 198 */	1,
	/* 199 */	0,
	/* 200 */	3,
	/* 201 */	0,
	/* 202 */	1,
	/* 203 */	0,
	/* 204 */	2,
	/* 205 */	0,
	/* 206 */	1,
	/* 207 */	0,
	/* 208 */	4,
	/* 209 */	0,
	/* 210 */	1,
	/* 211 */	0,
	/* 212 */	2,
	/* 213 */	0,
	/* 214 */	1,
	/* 215 */	0,
	/* 216 */	3,
	/* 217 */	0,
	/* 218 */	1,
	/* 219 */	0,
	/* 220 */	2,
	/* 221 */	0,
	/* 222 */	1,
	/* 223 */	0,
	/* 224 */	5,
	/* 225 */	0,
	/* 226 */	1,
	/* 227 */	0,
	/* 228 */	2,
	/* 229 */	0,
	/* 230 */	1,
	/* 231 */	0,
	/* 232 */	3,
	/* 233 */	0,
	/* 234 */	1,
	/* 235 */	0,
	/* 236 */	2,
	/* 237 */	0,
	/* 238 */	1,
	/* 239 */	0,
	/* 240 */	4,
	/* 241 */	0,
	/* 242 */	1,
	/* 243 */	0,
	/* 244 */	2,
	/* 245 */	0,
	/* 246 */	1,
	/* 247 */	0,
	/* 248 */	3,
	/* 249 */	0,
	/* 250 */	1,
	/* 251 */	0,
	/* 252 */	2,
	/* 253 */	0,
	/* 254 */	1,
	/* 255 */	0
};

/*
** Table to get bit count from index value 
*/

GLOBALDEF u_char bt_cnttab[] =
{
	/*   0 */	  0,
	/*   1 */	  1,
	/*   2 */	  1,
	/*   3 */	  2,
	/*   4 */	  1,
	/*   5 */	  2,
	/*   6 */	  2,
	/*   7 */	  3,
	/*   8 */	  1,
	/*   9 */	  2,
	/*  10 */	  2,
	/*  11 */	  3,
	/*  12 */	  2,
	/*  13 */	  3,
	/*  14 */	  3,
	/*  15 */	  4,
	/*  16 */	  1,
	/*  17 */	  2,
	/*  18 */	  2,
	/*  19 */	  3,
	/*  20 */	  2,
	/*  21 */	  3,
	/*  22 */	  3,
	/*  23 */	  4,
	/*  24 */	  2,
	/*  25 */	  3,
	/*  26 */	  3,
	/*  27 */	  4,
	/*  28 */	  3,
	/*  29 */	  4,
	/*  30 */	  4,
	/*  31 */	  5,
	/*  32 */	  1,
	/*  33 */	  2,
	/*  34 */	  2,
	/*  35 */	  3,
	/*  36 */	  2,
	/*  37 */	  3,
	/*  38 */	  3,
	/*  39 */	  4,
	/*  40 */	  2,
	/*  41 */	  3,
	/*  42 */	  3,
	/*  43 */	  4,
	/*  44 */	  3,
	/*  45 */	  4,
	/*  46 */	  4,
	/*  47 */	  5,
	/*  48 */	  2,
	/*  49 */	  3,
	/*  50 */	  3,
	/*  51 */	  4,
	/*  52 */	  3,
	/*  53 */	  4,
	/*  54 */	  4,
	/*  55 */	  5,
	/*  56 */	  3,
	/*  57 */	  4,
	/*  58 */	  4,
	/*  59 */	  5,
	/*  60 */	  4,
	/*  61 */	  5,
	/*  62 */	  5,
	/*  63 */	  6,
	/*  64 */	  1,
	/*  65 */	  2,
	/*  66 */	  2,
	/*  67 */	  3,
	/*  68 */	  2,
	/*  69 */	  3,
	/*  70 */	  3,
	/*  71 */	  4,
	/*  72 */	  2,
	/*  73 */	  3,
	/*  74 */	  3,
	/*  75 */	  4,
	/*  76 */	  3,
	/*  77 */	  4,
	/*  78 */	  4,
	/*  79 */	  5,
	/*  80 */	  2,
	/*  81 */	  3,
	/*  82 */	  3,
	/*  83 */	  4,
	/*  84 */	  3,
	/*  85 */	  4,
	/*  86 */	  4,
	/*  87 */	  5,
	/*  88 */	  3,
	/*  89 */	  4,
	/*  90 */	  4,
	/*  91 */	  5,
	/*  92 */	  4,
	/*  93 */	  5,
	/*  94 */	  5,
	/*  95 */	  6,
	/*  96 */	  2,
	/*  97 */	  3,
	/*  98 */	  3,
	/*  99 */	  4,
	/* 100 */	  3,
	/* 101 */	  4,
	/* 102 */	  4,
	/* 103 */	  5,
	/* 104 */	  3,
	/* 105 */	  4,
	/* 106 */	  4,
	/* 107 */	  5,
	/* 108 */	  4,
	/* 109 */	  5,
	/* 110 */	  5,
	/* 111 */	  6,
	/* 112 */	  3,
	/* 113 */	  4,
	/* 114 */	  4,
	/* 115 */	  5,
	/* 116 */	  4,
	/* 117 */	  5,
	/* 118 */	  5,
	/* 119 */	  6,
	/* 120 */	  4,
	/* 121 */	  5,
	/* 122 */	  5,
	/* 123 */	  6,
	/* 124 */	  5,
	/* 125 */	  6,
	/* 126 */	  6,
	/* 127 */	  7,
	/* 128 */	  1,
	/* 129 */	  2,
	/* 130 */	  2,
	/* 131 */	  3,
	/* 132 */	  2,
	/* 133 */	  3,
	/* 134 */	  3,
	/* 135 */	  4,
	/* 136 */	  2,
	/* 137 */	  3,
	/* 138 */	  3,
	/* 139 */	  4,
	/* 140 */	  3,
	/* 141 */	  4,
	/* 142 */	  4,
	/* 143 */	  5,
	/* 144 */	  2,
	/* 145 */	  3,
	/* 146 */	  3,
	/* 147 */	  4,
	/* 148 */	  3,
	/* 149 */	  4,
	/* 150 */	  4,
	/* 151 */	  5,
	/* 152 */	  3,
	/* 153 */	  4,
	/* 154 */	  4,
	/* 155 */	  5,
	/* 156 */	  4,
	/* 157 */	  5,
	/* 158 */	  5,
	/* 159 */	  6,
	/* 160 */	  2,
	/* 161 */	  3,
	/* 162 */	  3,
	/* 163 */	  4,
	/* 164 */	  3,
	/* 165 */	  4,
	/* 166 */	  4,
	/* 167 */	  5,
	/* 168 */	  3,
	/* 169 */	  4,
	/* 170 */	  4,
	/* 171 */	  5,
	/* 172 */	  4,
	/* 173 */	  5,
	/* 174 */	  5,
	/* 175 */	  6,
	/* 176 */	  3,
	/* 177 */	  4,
	/* 178 */	  4,
	/* 179 */	  5,
	/* 180 */	  4,
	/* 181 */	  5,
	/* 182 */	  5,
	/* 183 */	  6,
	/* 184 */	  4,
	/* 185 */	  5,
	/* 186 */	  5,
	/* 187 */	  6,
	/* 188 */	  5,
	/* 189 */	  6,
	/* 190 */	  6,
	/* 191 */	  7,
	/* 192 */	  2,
	/* 193 */	  3,
	/* 194 */	  3,
	/* 195 */	  4,
	/* 196 */	  3,
	/* 197 */	  4,
	/* 198 */	  4,
	/* 199 */	  5,
	/* 200 */	  3,
	/* 201 */	  4,
	/* 202 */	  4,
	/* 203 */	  5,
	/* 204 */	  4,
	/* 205 */	  5,
	/* 206 */	  5,
	/* 207 */	  6,
	/* 208 */	  3,
	/* 209 */	  4,
	/* 210 */	  4,
	/* 211 */	  5,
	/* 212 */	  4,
	/* 213 */	  5,
	/* 214 */	  5,
	/* 215 */	  6,
	/* 216 */	  4,
	/* 217 */	  5,
	/* 218 */	  5,
	/* 219 */	  6,
	/* 220 */	  5,
	/* 221 */	  6,
	/* 222 */	  6,
	/* 223 */	  7,
	/* 224 */	  3,
	/* 225 */	  4,
	/* 226 */	  4,
	/* 227 */	  5,
	/* 228 */	  4,
	/* 229 */	  5,
	/* 230 */	  5,
	/* 231 */	  6,
	/* 232 */	  4,
	/* 233 */	  5,
	/* 234 */	  5,
	/* 235 */	  6,
	/* 236 */	  5,
	/* 237 */	  6,
	/* 238 */	  6,
	/* 239 */	  7,
	/* 240 */	  4,
	/* 241 */	  5,
	/* 242 */	  5,
	/* 243 */	  6,
	/* 244 */	  5,
	/* 245 */	  6,
	/* 246 */	  6,
	/* 247 */	  7,
	/* 248 */	  5,
	/* 249 */	  6,
	/* 250 */	  6,
	/* 251 */	  7,
	/* 252 */	  6,
	/* 253 */	  7,
	/* 254 */	  7,
	/* 255 */	  8
};

/* end of bttabs.roc */
