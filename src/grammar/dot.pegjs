{
    errors=[];
    var lint = options.pegace.mode=='lint';
}

dotsource = _* ("strict"? _+)? ("graph" / "digraph" / u_keyword) (_+ ID)? _* '{' stmt_list? _* '}' _*
    {return {errors: errors, clean: errors.length==0};}
stmt_list = (_* stmt eos?)+
stmt = subgraph 
	/ struct
	/ attr_stmt
	/ ID _* '=' _* (QS / ID)
	/ edge_stmt
	/ node_stmt
eos = _* (';' / CR)
struct = '{' stmt_list? _* '}'
attr_stmt = ("graph" / "node" / "edge") _* attr_list
u_keyword = &{return lint} e:[^ ]+ {errors.push({pos: offset, text:"Unknown keyword '"+e.join('')+"'"})}
attr_list = '[' _* a_list? _* ']' attr_list?
a_list    = a_name _* '=' _* (ID / QS) (a_sep a_list)*
    / &{return lint} e:ID _* '=' _* (ID / QS) (a_sep a_list)* {errors.push({pos: offset, text: "Unknown attribute '"+e.join('')+"'"})}
a_sep     = (',' / _) _*
edge_stmt = (node_id / subgraph) edgeRHS _* attr_list?
edgeRHS   = _* edgeop _* (node_id / subgraph) edgeRHS?
node_stmt = node_id _* attr_list?
node_id   = ID _* port?
port 	  = ':' _* ID ( ':' _* compass_pt)?
	/ 	':' _* compass_pt
subgraph  = ("subgraph" _+ ID?)? _* '{' stmt_list _* '}'
compass_pt = "n" / "ne" / "e" / "se" / "s" / "sw" / "w" / "nw" / "c"
edgeop = "--" / "->"
comment "comment" = lcomment / bcomment / pcomment
lcomment = "//" [^\n]*
pcomment = CR "#" [^\n]*
bcomment = "/*" [^*]* "*"+ ([^/*] [^*]* "*"+)* "/"

a_name =
    "damping"
	/ "k"
	/ "url"
	/ "area"
	/ "arrowhead"
	/ "arrowsize"
	/ "arrowtail"
	/ "aspect"
	/ "bb"
	/ "bgcolor"
	/ "center"
	/ "charset"
	/ "clusterrank"
	/ "colorscheme"
	/ "color"
	/ "comment"
	/ "compound"
	/ "concentrate"
	/ "constraint"
	/ "decorate"
	/ "defaultdist"
	/ "dimen"
	/ "dim"
	/ "diredgeconstraints"
	/ "dir"
	/ "distortion"
	/ "dpi"
	/ "edgeurl"
	/ "edgehref"
	/ "edgetarget"
	/ "edgetooltip"
	/ "epsilon"
	/ "esep"
	/ "fillcolor"
	/ "fixedsize"
	/ "fontcolor"
	/ "fontname"
	/ "fontnames"
	/ "fontpath"
	/ "fontsize"
	/ "forcelabels"
	/ "gradientangle"
	/ "group"
	/ "headurl"
	/ "head_lp"
	/ "headclip"
	/ "headhref"
	/ "headlabel"
	/ "headport"
	/ "headtarget"
	/ "headtooltip"
	/ "height"
	/ "href"
	/ "id"
	/ "imagepath"
	/ "imagescale"
	/ "image"
	/ "labelurl"
	/ "label_scheme"
	/ "labelangle"
	/ "labeldistance"
	/ "labelfloat"
	/ "labelfontcolor"
	/ "labelfontname"
	/ "labelfontsize"
	/ "labelhref"
	/ "labeljust"
	/ "labelloc"
	/ "labeltarget"
	/ "labeltooltip"
	/ "landscape"
	/ "label"
	/ "layerlistsep"
	/ "layerselect"
	/ "layersep"
	/ "layers"
	/ "layer"
	/ "layout"
	/ "len"
	/ "levels"
	/ "levelsgap"
	/ "lhead"
	/ "lheight"
	/ "lp"
	/ "ltail"
	/ "lwidth"
	/ "margin"
	/ "maxiter"
	/ "mclimit"
	/ "mindist"
	/ "minlen"
	/ "model"
	/ "mode"
	/ "mosek"
	/ "nodesep"
	/ "nojustify"
	/ "normalize"
	/ "nslimit"
	/ "nslimit1"
	/ "ordering"
	/ "orientation"
	/ "outputorder"
	/ "overlap"
	/ "overlap_scaling"
	/ "pack"
	/ "packmode"
	/ "pad"
	/ "page"
	/ "pagedir"
	/ "pencolor"
	/ "penwidth"
	/ "peripheries"
	/ "pin"
	/ "pos"
	/ "quadtree"
	/ "quantum"
	/ "rankdir"
	/ "ranksep"
	/ "rank"
	/ "ratio"
	/ "rects"
	/ "regular"
	/ "remincross"
	/ "repulsiveforce"
	/ "resolution"
	/ "root"
	/ "rotate"
	/ "rotation"
	/ "samehead"
	/ "sametail"
	/ "samplepoints"
	/ "scale"
	/ "searchsize"
	/ "sep"
	/ "shape"
	/ "shapefile"
	/ "showboxes"
	/ "sides"
	/ "size"
	/ "skew"
	/ "smoothing"
	/ "sortv"
	/ "splines"
	/ "start"
	/ "style"
	/ "stylesheet"
	/ "tailurl"
	/ "tail_lp"
	/ "tailclip"
	/ "tailhref"
	/ "taillabel"
	/ "tailport"
	/ "tailtarget"
	/ "tailtooltip"
	/ "target"
	/ "tooltip"
	/ "truecolor"
	/ "vertices"
	/ "viewport"
	/ "voro_margin"
	/ "weight"
	/ "width"
	/ "xlabel"
	/ "xlp"
	/ "z"

ID = [a-zA-Z0-9_\.]+ / '-'? [0-9]* '.'? [0-9] / QS
QS = '"' [^"]* '"' / "<<" ([^>] [^>]* ">")* ">"

CR = [\r]?[\n]?
_ "whitespace" = comment / [\n\r\t ]