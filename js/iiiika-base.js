(function(jscl){
'use strict';
(function(values, internals){
var l1=internals.intern('*PACKAGE*','COMMON-LISP');
var l2=internals.intern('IIIIKA','KEYWORD');
l2.value=l2;
var l3=internals.intern('FIND-PACKAGE-OR-FAIL');
l1.value=l3.fvalue(internals.pv,l2);
var l4=internals.intern('LIST','COMMON-LISP');
var l5=internals.intern('DEFINE-RULE','IIIIKA');
var l6=internals.intern('KATAKANA','KEYWORD');
l6.value=l6;
var l7=internals.intern('NI','KEYWORD');
l7.value=l7;
var l8=internals.intern('NIL','COMMON-LISP');
var l9=internals.QIList(l6,l7,l8);
var l10=internals.intern('MI','KEYWORD');
l10.value=l10;
var l11=internals.QIList(l6,l10,l8);
var l12=internals.intern('HIRAGANA','KEYWORD');
l12.value=l12;
var l13=internals.intern('E','KEYWORD');
l13.value=l13;
var l14=internals.QIList(l12,l13,l8);
var l15=internals.intern('YU','KEYWORD');
l15.value=l15;
var l16=internals.intern('SU','KEYWORD');
l16.value=l16;
var l17=internals.QIList(l12,l16,l8);
var l18=internals.intern('SE','KEYWORD');
l18.value=l18;
var l19=internals.QIList(l12,l18,l8);
var l20=internals.intern('NU','KEYWORD');
l20.value=l20;
var l21=internals.QIList(l12,l20,l8);
var l22=internals.intern('FU','KEYWORD');
l22.value=l22;
var l23=internals.QIList(l12,l22,l8);
var l24=internals.intern('RO','KEYWORD');
l24.value=l24;
var l25=internals.QIList(l12,l24,l8);
var l26=internals.intern('A','KEYWORD');
l26.value=l26;
var l27=internals.QIList(l6,l26,l8);
var l28=internals.QIList(l6,l13,l8);
var l29=internals.intern('O','KEYWORD');
l29.value=l29;
var l30=internals.QIList(l6,l29,l8);
var l31=internals.intern('KA','KEYWORD');
l31.value=l31;
var l32=internals.QIList(l6,l31,l8);
var l33=internals.intern('TI','KEYWORD');
l33.value=l33;
var l34=internals.QIList(l6,l33,l8);
var l35=internals.intern('TO','KEYWORD');
l35.value=l35;
var l36=internals.QIList(l6,l35,l8);
var l37=internals.intern('TA','KEYWORD');
l37.value=l37;
var l38=internals.QIList(l6,l37,l8);
var l39=internals.intern('HA','KEYWORD');
l39.value=l39;
var l40=internals.QIList(l6,l39,l8);
var l41=internals.QIList(l6,l18,l8);
var l42=internals.QIList(l6,l24,l8);
var l43=internals.intern('口字旁','KEYWORD');
l43.value=l43;
var l44=internals.intern('ENGLISH','KEYWORD');
l44.value=l44;
var l45=internals.intern('LOWER-O','KEYWORD');
l45.value=l45;
var l46=internals.QIList(l44,l45,l8);
var l47=internals.intern('女字旁','KEYWORD');
l47.value=l47;
var l48=internals.intern('双耳旁','KEYWORD');
l48.value=l48;
var l49=internals.intern('日字旁','KEYWORD');
l49.value=l49;
var l50=internals.intern('绞丝旁','KEYWORD');
l50.value=l50;
var l51=internals.intern('双点水','KEYWORD');
l51.value=l51;
var l52=internals.intern('三点水','KEYWORD');
l52.value=l52;
var l53=internals.intern('单人旁','KEYWORD');
l53.value=l53;
var l54=internals.intern('I','KEYWORD');
l54.value=l54;
var l55=internals.QIList(l6,l54,l8);
var l56=internals.intern('双人旁','KEYWORD');
l56.value=l56;
var l57=internals.QIList(l6,l33,l8);
var l58=internals.intern('提手旁','KEYWORD');
l58.value=l58;
var l59=internals.intern('KI','KEYWORD');
l59.value=l59;
var l60=internals.QIList(l6,l59,l8);
var l61=internals.intern('王字旁','KEYWORD');
l61.value=l61;
var l62=internals.intern('MO','KEYWORD');
l62.value=l62;
var l63=internals.QIList(l6,l62,l8);
var l64=internals.intern('立刀旁','KEYWORD');
l64.value=l64;
var l65=internals.intern('RI','KEYWORD');
l65.value=l65;
var l66=internals.QIList(l6,l65,l8);
var l67=internals.intern('示字旁','KEYWORD');
l67.value=l67;
var l68=internals.intern('NE','KEYWORD');
l68.value=l68;
var l69=internals.QIList(l6,l68,l8);
l5.fvalue(internals.pv,'零',l4.fvalue(internals.pv,'0'));
l5.fvalue(internals.pv,'一',l4.fvalue(internals.pv,'-'));
l5.fvalue(internals.pv,'二',l4.fvalue(internals.pv,l9));
l5.fvalue(internals.pv,'三',l4.fvalue(internals.pv,l11));
l5.fvalue(internals.pv,'羊',l4.fvalue(internals.pv,'¥'));
l5.fvalue(internals.pv,'申',l4.fvalue(internals.pv,'φ'));
l5.fvalue(internals.pv,'十',l4.fvalue(internals.pv,'+'));
l5.fvalue(internals.pv,'丫',l4.fvalue(internals.pv,'Y'));
l5.fvalue(internals.pv,'元',l4.fvalue(internals.pv,l14));
l5.fvalue(internals.pv,'中',l4.fvalue(internals.pv,l12.value,l15.value));
l5.fvalue(internals.pv,'可',l4.fvalue(internals.pv,l17));
l5.fvalue(internals.pv,'世',l4.fvalue(internals.pv,l19));
l5.fvalue(internals.pv,'奴',l4.fvalue(internals.pv,l21));
l5.fvalue(internals.pv,'尔',l4.fvalue(internals.pv,l23));
l5.fvalue(internals.pv,'子',l4.fvalue(internals.pv,l25));
l5.fvalue(internals.pv,'丁',l4.fvalue(internals.pv,l27));
l5.fvalue(internals.pv,'工',l4.fvalue(internals.pv,l28));
l5.fvalue(internals.pv,'才',l4.fvalue(internals.pv,l30));
l5.fvalue(internals.pv,'力',l4.fvalue(internals.pv,l32));
l5.fvalue(internals.pv,'刀',l4.fvalue(internals.pv,l32));
l5.fvalue(internals.pv,'千',l4.fvalue(internals.pv,l34));
l5.fvalue(internals.pv,'不',l4.fvalue(internals.pv,l36));
l5.fvalue(internals.pv,'夕',l4.fvalue(internals.pv,l38));
l5.fvalue(internals.pv,'八',l4.fvalue(internals.pv,l40));
l5.fvalue(internals.pv,'也',l4.fvalue(internals.pv,l41));
l5.fvalue(internals.pv,'巴',l4.fvalue(internals.pv,l41));
l5.fvalue(internals.pv,'口',l4.fvalue(internals.pv,l42));
l5.fvalue(internals.pv,l43.value,l4.fvalue(internals.pv,l46));
l5.fvalue(internals.pv,l47.value,l4.fvalue(internals.pv,'δ'));
l5.fvalue(internals.pv,'女',l4.fvalue(internals.pv,'δ'));
l5.fvalue(internals.pv,l48.value,l4.fvalue(internals.pv,'β'));
l5.fvalue(internals.pv,'阝',l4.fvalue(internals.pv,'β'));
l5.fvalue(internals.pv,l49.value,l4.fvalue(internals.pv,'θ'));
l5.fvalue(internals.pv,'日',l4.fvalue(internals.pv,'θ'));
l5.fvalue(internals.pv,l50.value,l4.fvalue(internals.pv,'ξ'));
l5.fvalue(internals.pv,'纟',l4.fvalue(internals.pv,'ξ'));
l5.fvalue(internals.pv,l51.value,l4.fvalue(internals.pv,':'));
l5.fvalue(internals.pv,'冫',l4.fvalue(internals.pv,':'));
l5.fvalue(internals.pv,l52.value,l4.fvalue(internals.pv,'Ξ'));
l5.fvalue(internals.pv,'氵',l4.fvalue(internals.pv,'Ξ'));
l5.fvalue(internals.pv,l53.value,l4.fvalue(internals.pv,l55));
l5.fvalue(internals.pv,'亻',l4.fvalue(internals.pv,l55));
l5.fvalue(internals.pv,l56.value,l4.fvalue(internals.pv,l57));
l5.fvalue(internals.pv,'彳',l4.fvalue(internals.pv,l57));
l5.fvalue(internals.pv,l58.value,l4.fvalue(internals.pv,l60));
l5.fvalue(internals.pv,'扌',l4.fvalue(internals.pv,l60));
l5.fvalue(internals.pv,l61.value,l4.fvalue(internals.pv,l63));
l5.fvalue(internals.pv,'𤣩',l4.fvalue(internals.pv,l63));
l5.fvalue(internals.pv,l64.value,l4.fvalue(internals.pv,l66));
l5.fvalue(internals.pv,'刂',l4.fvalue(internals.pv,l66));
l5.fvalue(internals.pv,l67.value,l4.fvalue(internals.pv,l69));
l5.fvalue(internals.pv,'礻',l4.fvalue(internals.pv,l69));
l5.fvalue(internals.pv,'我',l4.fvalue(internals.pv,'チ','ギ'));
l5.fvalue(internals.pv,'久',l4.fvalue(internals.pv,'ク','、'));
l5.fvalue(internals.pv,'人',l4.fvalue(internals.pv,'ノ','、'));
l5.fvalue(internals.pv,'么',l4.fvalue(internals.pv,'ノ','ム'));
l5.fvalue(internals.pv,'山',l4.fvalue(internals.pv,'ι','υ'));
l5.fvalue(internals.pv,'小',l4.fvalue(internals.pv,'·','」','·'));
l5.fvalue(internals.pv,'水',l4.fvalue(internals.pv,'フ','」','く'));
l5.fvalue(internals.pv,'从',l4.fvalue(internals.pv,'人','人'));
l5.fvalue(internals.pv,'北',l4.fvalue(internals.pv,'ヲ','ヒ'));
l5.fvalue(internals.pv,'云',l4.fvalue(internals.pv,'テ','.'));
l5.fvalue(internals.pv,'天',l4.fvalue(internals.pv,'.','モ'));
l5.fvalue(internals.pv,'无',l4.fvalue(internals.pv,'.','モ'));
l5.fvalue(internals.pv,'冰',l4.fvalue(internals.pv,l51.value,'水'));
l5.fvalue(internals.pv,'队',l4.fvalue(internals.pv,l48.value,'人'));
l5.fvalue(internals.pv,'阿',l4.fvalue(internals.pv,l48.value,'可'));
l5.fvalue(internals.pv,'神',l4.fvalue(internals.pv,l67.value,'申'));
l5.fvalue(internals.pv,'阳',l4.fvalue(internals.pv,l48.value,'日'));
l5.fvalue(internals.pv,'红',l4.fvalue(internals.pv,l50.value,'工'));
l5.fvalue(internals.pv,'他',l4.fvalue(internals.pv,l53.value,'也'));
l5.fvalue(internals.pv,'你',l4.fvalue(internals.pv,l53.value,'尔'));
l5.fvalue(internals.pv,'什',l4.fvalue(internals.pv,l53.value,'十'));
l5.fvalue(internals.pv,'仙',l4.fvalue(internals.pv,l53.value,'山'));
l5.fvalue(internals.pv,'行',l4.fvalue(internals.pv,l56.value,'丁'));
l5.fvalue(internals.pv,'打',l4.fvalue(internals.pv,l58.value,'丁'));
l5.fvalue(internals.pv,'咩',l4.fvalue(internals.pv,l43.value,'羊'));
l5.fvalue(internals.pv,'吖',l4.fvalue(internals.pv,l43.value,'丫'));
l5.fvalue(internals.pv,'啊',l4.fvalue(internals.pv,l43.value,'阿'));
l5.fvalue(internals.pv,'加',l4.fvalue(internals.pv,'力',l43.value));
l5.fvalue(internals.pv,'班',l4.fvalue(internals.pv,l61.value,l64.value,l61.value));
})(jscl.internals.pv, jscl.internals);
})( typeof require !== 'undefined'? require('./jscl'): window.jscl )
