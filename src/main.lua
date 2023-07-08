local obversion = "v1.0.0"

if game ~= nil and typeof ~= nil then
	print(
		"This Obfuscator cannot be ran in Roblox or luau. (but results can be ran in Roblox)"
	)
	return
end

-- check is this cli mode
local climode = arg ~= nil and true or false

if table.find == nil then
	table.find = function(tbl,value,pos)
		for i = pos or 1,#tbl do
			if tbl[i] == value then
				return i
			end
		end
	end
end

local realargs = nil do
	if climode == true then
		if #arg <= 1 and arg[1] == "--help" or arg[1] == "-h" or arg[1] == nil then
			print(
				"ShinyMoon " .. obversion .. " - luau Obfuscator written in lua\n" ..
				"Copyright (c) 2023 Reboy / M0dder" .. "\n" 
			)
			print(
				"Usage:" .. "\n" ..
				arg[0] .. " --source \"<FILE_PATH>\" --output \"<FILE_PATH>\" [OPTIONS]\n" ..
				"\n" ..
				"Available Arguments:" .. "\n" ..
				"--help -h		Shows help.\n" ..
				"-S --silent		Run Obfuscation without outputting to terminal anything.\n" ..
				"-s --source \"<FILE_PATH>\" 	Path to Lua script to obfuscate." .. "\n" ..
				"-o --output \"<FILE_PATH>\" 	Path to Lua script to output (document will be created if there isn't)." .. "\n" ..
				"Output file will be overwritten if it exists.\n" ..
				"-c --comment \"<COMMENT>\" 	Comment Option." .. "\n" ..
				"-vc --varcomm \"<COMMENT>\" 	Comment Option for lua variable value." .. "\n" ..
				"-vn --varname \"<STRING>\" 	Lua variable name (Special characters, spaces will be replaced with underline)." .. "\n" ..
				"-C --cryptvarcomm  	Encode (Decodable) comment for vartiable value." .. "\n" ..
				"-f --force  	Ignores all warnings.\n" ..
				"-of --openfile		Open an obfuscated file after obfuscation. (Windows: notepad, Unix: '$EDITOR')\n" ..
				"" .. "\n"
			)
			return
		end
		realargs = {}
		local nextvargs = {"source","output","comment","varcomm","varname"}
		local longargs = {s="source",o="output",c="comment",vc="varcomm",vn="varname",C="cryptvarcomm",f="force",S="silent",of="openfile"}
		local skipdexes = {}
		for i,v in pairs(arg) do
			if (not table.find(skipdexes,i)) or (i > 0) then
				if v:sub(1,2) == "--" then
					if table.find(nextvargs,v:sub(3)) then
						realargs[v:sub(3)] = arg[i+1]
						table.insert(skipdexes,(#skipdexes+1),(i+1))
					else
						realargs[v:sub(3)] = true
					end
				elseif v:sub(1,1) == "-" then
					if table.find(nextvargs,longargs[v:sub(2)]) then
						realargs[longargs[v:sub(2)]] = arg[i+1]
						table.insert(skipdexes,(#skipdexes+1),(i+1))
					else
						realargs[longargs[v:sub(2)]] = true
					end
				end
			end
		end
	end
end

local M = {}

local charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'--64
local morecharset = charset..'!@#$%&*()-=[];\'",./_+{}:|<>?'
local fenv = getfenv or function()
	return _ENV
end

--local loadstring_ = loadstring
local bintype = package.cpath:match("%p[\\|/]?%p(%a+)")
local curos = bintype == "dll" and "win" or (bintype == "so" and "linux" or "macos")

local resources = { -- FAKE Yueliang
	Yueliang = function(srcfile)return io.popen((curos == "win" and "" or "./").."luau-"..(curos).." --compile=binary "..srcfile):read("*a")end,
--	Fiu
	FiOneCode = [==[(function()local a=false;local b=string.unpack;local c=table.pack;local d=table.create;local e=table.move;local f=coroutine.create;local g=coroutine.yield;local h=coroutine.resume;local i=tonumber;local j=pcall;local function k()return{slist={},plist={}}end;local function l()return{code={},k={},protos={}}end;local m={{"NOP",0},{"BREAK",0},{"LOADNIL",1},{"LOADB",3},{"LOADN",4},{"LOADK",4},{"MOVE",2},{"GETGLOBAL",1,true},{"SETGLOBAL",1,true},{"GETUPVAL",2},{"SETUPVAL",2},{"CLOSEUPVALS",1},{"GETIMPORT",4,true},{"GETTABLE",3},{"SETTABLE",3},{"GETTABLEKS",3,true},{"SETTABLEKS",3,true},{"GETTABLEN",3},{"SETTABLEN",3},{"NEWCLOSURE",4},{"NAMECALL",3,true},{"CALL",3},{"RETURN",2},{"JUMP",4},{"JUMPBACK",4},{"JUMPIF",4},{"JUMPIFNOT",4},{"JUMPIFEQ",4,true},{"JUMPIFLE",4,true},{"JUMPIFLT",4,true},{"JUMPIFNOTEQ",4,true},{"JUMPIFNOTLE",4,true},{"JUMPIFNOTLT",4,true},{"ADD",3},{"SUB",3},{"MUL",3},{"DIV",3},{"MOD",3},{"POW",3},{"ADDK",3},{"SUBK",3},{"MULK",3},{"DIVK",3},{"MODK",3},{"POWK",3},{"AND",3},{"OR",3},{"ANDK",3},{"ORK",3},{"CONCAT",3},{"NOT",2},{"MINUS",2},{"LENGTH",2},{"NEWTABLE",2,true},{"DUPTABLE",4},{"SETLIST",3,true},{"FORNPREP",4},{"FORNLOOP",4},{"FORGLOOP",4,true},{"FORGPREP_INEXT",4},{"LOP_DEP_FORGLOOP_INEXT",0},{"FORGPREP_NEXT",4},{"LOP_DEP_FORGLOOP_NEXT",0},{"GETVARARGS",2},{"DUPCLOSURE",4},{"PREPVARARGS",1},{"LOADKX",1,true},{"JUMPX",5},{"FASTCALL",3},{"COVERAGE",5},{"CAPTURE",2},{"LOP_DEP_JUMPIFEQK",0},{"LOP_DEP_JUMPIFNOTEQK",0},{"FASTCALL1",3},{"FASTCALL2",3,true},{"FASTCALL2K",3,true},{"FORGPREP",4},{"JUMPXEQKNIL",4,true},{"JUMPXEQKB",4,true},{"JUMPXEQKN",4,true},{"JUMPXEQKS",4,true}}local n={}for a,b in next,m do if b[3]then table.insert(n,a)end end;local o=-1;local p=-2;local function q(a)local c=1;local d=k()local e=d.slist;local f=d.plist;local function g()local a=b(">B",a,c)c=c+1;return a end;local function h()local a=b("I4",a,c)c=c+4;return a end;local function i()local a=0;for b=0,7 do local c=g()a=bit32.bor(a,bit32.lshift(bit32.band(c,127),b*7))if bit32.band(c,128)==0 then break end end;return a end;local function j()local d=i()local e;if d==0 then return""else e=b("c"..d,a,c)c=c+d end;return e end;local function k(a)local b={}local c=h()local d=bit32.band(c,255)b.value=c;b.opcode=d;local e=m[d+1]b.opname=e[1]local e=e[2]b.type=e;local e=b.type;if e==3 then b.A=bit32.band(bit32.rshift(c,8),255)b.B=bit32.band(bit32.rshift(c,16),255)b.C=bit32.band(bit32.rshift(c,24),255)elseif e==2 then b.A=bit32.band(bit32.rshift(c,8),255)b.B=bit32.band(bit32.rshift(c,16),255)elseif e==1 then b.A=bit32.band(bit32.rshift(c,8),255)elseif e==4 then b.A=bit32.band(bit32.rshift(c,8),255)local a=bit32.band(bit32.rshift(c,16),65535)b.D=a<32768 and a or a-65536 elseif e==5 then local a=bit32.band(bit32.rshift(c,8),16777215)b.E=a<8388608 and a or a-16777216 end;if table.find(n,d+1)then local c=h()b.aux=c;table.insert(a,b)table.insert(a,{value=c})return true end;table.insert(a,b)return false end;local function m()local e=l()e.maxstacksize=g()e.numparams=g()e.nups=g()e.isvararg=g()~=0;local f=e.code;local j=i()e.sizecode=j;local l=false;for a=1,j do if l then l=false;continue end;l=k(f)end;local f=e.k;local k=i()e.sizek=k;for e=1,k do local e=g()local j;if e==0 then j=nil elseif e==1 then j=g()~=0 elseif e==2 then local a=b("d",a,c)c=c+8;j=a elseif e==3 then j=d.slist[i()]elseif e==4 then j=h()elseif e==5 then local a={}local b=i()for b=1,b do table.insert(a,i())end;j=a elseif e==6 then j=i()end;table.insert(f,j)end;local a=i()local b=e.protos;e.sizep=a;for a=1,a do table.insert(b,i())end;i()i()if g()~=0 then local a=g()for a=1,j do g()end;local a=bit32.rshift(j-1,a)+1;for a=1,a do h()end end;if g()~=0 then local a=i()for a=1,a do i()i()i()g()end end;return e end;local b=g()local b=i()for a=1,b do table.insert(e,j())end;local b=i()for a=1,b do table.insert(f,m())end;d.mainp=i()assert(c==#a+1,"Deserializer position mismatch")return d end;local function b(b,k)if type(b)=="string"then b=q(b)end;local l=b.plist;local m=l[b.mainp+1]local function n(b,m,q)local function r(a,j,r,r,s)local t,u,v,w=-1,1,{},{}local x=m.k;while true do local y=r[u]local z=y.opcode;u+=1;a.pc=u;a.name=y.opname;if z==2 then j[y.A]=nil elseif z==3 then j[y.A]=y.B~=0;u+=y.C elseif z==4 then j[y.A]=y.D elseif z==5 then j[y.A]=x[y.D+1]elseif z==6 then j[y.A]=j[y.B]elseif z==7 then u+=1;local a=x[aux+1]assert(type(a)=="string","GETGLOBAL encountered non-string constant!")j[y.A]=k[a]elseif z==8 then u+=1;local a=x[y.aux+1]assert(type(a)=="string","GETGLOBAL encountered non-string constant!")k[a]=j[y.A]elseif z==9 then local a=q[y.B+1]j[y.A]=a.store[a.index]elseif z==10 then local a=q[y.B+1]a.store[a.index]=j[y.A]elseif z==11 then for a,b in v do if b.index>=y.A then b.value=b.store[b.index]b.store=b;b.index="value"v[a]=nil end end elseif z==12 then u+=1;local a=y.aux;local b=bit32.rshift(a,30)local c=bit32.band(bit32.rshift(a,20),1023)if b==1 then j[y.A]=k[x[c+1]]elseif b==2 then local a=bit32.band(bit32.rshift(a,10),1023)j[y.A]=k[x[c+1]][x[a+1]]elseif b==3 then local b=bit32.band(bit32.rshift(a,10),1023)local a=bit32.band(bit32.rshift(a,0),1023)j[y.A]=k[x[c+1]][x[b+1]][x[a+1]]end elseif z==13 then j[y.A]=j[y.B][j[y.C]]elseif z==14 then j[y.B][j[y.C]]=j[y.A]elseif z==15 then u+=1;local a=x[y.aux+1]j[y.A]=j[y.B][a]elseif z==16 then u+=1;local a=x[y.aux+1]j[y.B][a]=j[y.A]elseif z==17 then j[y.A]=j[y.B][y.C]elseif z==18 then j[y.B][y.C]=j[y.A]elseif z==19 then local a=l[y.D+1]local c={}for a=1,a.nups do local b=r[u]local d=b.opcode;u+=1;assert(d==70,"Unhandled opcode passed to NEWCLOSURE")local d=b.A;if d==0 then local b={value=j[b.B],index="value"}b.store=b;c[a]=b elseif d==1 then local b=b.B;local d=v[b]if d==nil then d={index=b,store=j}v[b]=d end;c[a]=d elseif d==2 then c[a]=q[b.B]end end;j[y.A]=n(b,a,c)elseif z==20 then u+=1;local a=y.A;local b=y.B;local c=x[y.aux+1]assert(type(c)=="string","NAMECALL encountered non-string constant!")j[a+1]=j[b]j[a]=j[b][c]elseif z==21 then local a,b,d=y.A,y.B,y.C;local b=b==0 and t-a or b-1;local b=c(j[a](table.unpack(j,a+1,a+b)))local c=b.n;if d==0 then t=a+c-1 else c=d-1 end;e(b,1,c,a,j)elseif z==22 then local a=y.A;local b=y.B;local c=b-1;local d;if c==o then d=t-a+1 else d=a+b-1-m.numparams end;return table.unpack(j,a,a+d-1)elseif z==23 then u+=y.D elseif z==24 then u+=y.D elseif z==25 then if j[y.A]then u+=y.D end elseif z==26 then if not j[y.A]then u+=y.D end elseif z==27 then if j[y.A]==j[y.aux]then u+=y.D else u+=1 end elseif z==28 then if j[y.A]<j[y.aux]then u+=y.D else u+=1 end elseif z==29 then if j[y.A]<=j[y.aux]then u+=y.D else u+=1 end elseif z==30 then if j[y.A]==j[y.aux]then u+=1 else u+=y.D end elseif z==31 then if j[y.A]<j[y.aux]then u+=1 else u+=y.D end elseif z==32 then if j[y.A]<=j[y.aux]then u+=1 else u+=y.D end elseif z==33 then j[y.A]=j[y.B]+j[y.C]elseif z==34 then j[y.A]=j[y.B]-j[y.C]elseif z==35 then j[y.A]=j[y.B]*j[y.C]elseif z==36 then j[y.A]=j[y.B]/j[y.C]elseif z==37 then j[y.A]=j[y.B]%j[y.C]elseif z==38 then j[y.A]=j[y.B]^j[y.C]elseif z==39 then j[y.A]=j[y.B]+x[y.C+1]elseif z==40 then j[y.A]=j[y.B]-x[y.C+1]elseif z==41 then j[y.A]=j[y.B]*x[y.C+1]elseif z==42 then j[y.A]=j[y.B]/x[y.C+1]elseif z==43 then j[y.A]=j[y.B]%x[y.C+1]elseif z==44 then j[y.A]=j[y.B]^x[y.C+1]elseif z==45 then local a=j[y.B]if not not a==false then j[y.A]=a else j[y.A]=j[y.C]or false end elseif z==46 then local a=j[y.B]if not not a==true then j[y.A]=a else j[y.A]=j[y.C]or false end elseif z==47 then local a=j[y.B]if not not a==false then j[y.A]=a else j[y.A]=x[y.C+1]or false end elseif z==48 then local a=j[y.B]if not not a==true then j[y.A]=a else j[y.A]=x[y.C+1]or false end elseif z==49 then local a=""for b=y.B,y.C do a..=j[b]end;j[y.A]=a elseif z==50 then j[y.A]=not j[y.B]elseif z==51 then j[y.A]=-j[y.B]elseif z==52 then j[y.A]=#j[y.B]elseif z==53 then u+=1;j[y.A]=d(y.aux)elseif z==54 then local a=x[y.D+1]local b={}for a,a in a do b[x[a+1]]=nil end;j[y.A]=b elseif z==55 then u+=1;local a=y.A;local b=y.B;local c=y.C-1;if c==o then c=t-b end;e(j,b,b+c,y.aux,j[a])elseif z==56 then local a=y.A;local b=j[a]if type(b)~="number"then local c=i(b)if c==nil then error("invalid 'for' limit (number expected)")end;j[a]=c;b=c end;local c=j[a+1]if type(c)~="number"then local b=i(c)if b==nil then error("invalid 'for' step (number expected)")end;j[a+1]=b;c=b end;local d=j[a+2]if type(d)~="number"then local b=i(d)if b==nil then error("invalid 'for' index (number expected)")end;j[a+2]=b;d=b end;local a=false;if c==math.abs(c)then a=d>=b else a=d<=b end;if a then u+=y.D end elseif z==57 then local a=y.A;local b=j[a]local c=j[a+1]local d=j[a+2]+c;local e=false;if c==math.abs(c)then e=d<=b else e=d>=b end;if e then j[a+2]=d;u+=y.D end elseif z==58 then local a=y.A;local b=y.aux;t=a+6;local c=j[a]if type(c)=="function"then local c={j[a](j[a+1],j[a+2])}e(c,1,b,a+3,j)if j[a+3]~=nil then j[a+2]=j[a+3]u+=y.D else u+=1 end else local c,c=h(w[y])if c==p then u+=1 else e(c,1,b,a+3,j)j[a+2]=j[a+3]u+=y.D end end elseif z==59 then if type(j[y.A])~="function"then error("FORGPREP_INEXT encountered non-function value")end;u+=y.D elseif z==61 then if type(j[y.A])~="function"then error("FORGPREP_NEXT encountered non-function value")end;u+=y.D elseif z==63 then local a=y.A;local b=y.B-1;if b==o then b=s.len;t=a+b-1 end;e(s.list,1,b,a,j)elseif z==64 then local a=l[x[y.D+1]+1]local c={}for a=1,a.nups do local b=r[u]local d=b.opcode;u+=1;assert(d==70,"Unhandled opcode passed to DUPCLOSURE")local d=b.A;if d==0 then local b={value=j[b.B],index="value"}b.store=b;c[a]=b elseif d==2 then c[a]=q[b.B]end end;j[y.A]=n(b,a,c)elseif z==65 then elseif z==66 then u+=1;local a=x[y.aux+1]assert(type(a)=="string","LOADKX encountered non-string constant!")j[y.A]=a elseif z==67 then u+=y.E elseif z==68 then elseif z==70 then error("Unhandled CAPTURE")elseif z==73 then elseif z==74 then u+=1 elseif z==75 then u+=1 elseif z==76 then local a=j[y.A]if type(a)~="function"then local b=r[u+y.D]if w[b]==nil then local function c()for a,b,c,d,e,f,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,ab,bb,cb,db,eb,fb,gb,hb,ib,jb,kb,lb,mb,nb,ob,pb,qb,rb,sb,tb,ub,vb,wb,xb,yb,zb,Ab,Bb,Cb,Db,Eb,Fb,Gb,Hb,Ib,Jb,Kb,Lb,Mb,Nb,Ob,Pb,Qb,Rb,Sb,Tb,Ub,Vb,Wb,Xb,Yb,Zb,ac,bc,cc,dc,ec,fc,gc,hc,ic,jc,kc,lc,mc,nc,oc,pc,qc,rc,sc,tc,uc,vc,wc,xc,yc,zc,Ac,Bc,Cc,Dc,Ec,Fc,Gc,Hc,Ic,Jc,Kc,Lc,Mc,Nc,Oc,Pc,Qc,Rc,Sc,Tc,Uc,Vc,Wc,Xc,Yc,Zc,ad,bd,cd,dd,ed,fd,gd,hd,id,jd,kd,ld,md,nd,od,pd,qd,rd,sd,td,ud,vd,wd,xd,yd,zd,Ad,Bd,Cd,Dd,Ed,Fd,Gd,Hd,Id,Jd,Kd,Ld,Md,Nd,Od,Pd,Qd,Rd,Sd in a do g({a,b,c,d,e,f,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,ab,bb,cb,db,eb,fb,gb,hb,ib,jb,kb,lb,mb,nb,ob,pb,qb,rb,sb,tb,ub,vb,wb,xb,yb,zb,Ab,Bb,Cb,Db,Eb,Fb,Gb,Hb,Ib,Jb,Kb,Lb,Mb,Nb,Ob,Pb,Qb,Rb,Sb,Tb,Ub,Vb,Wb,Xb,Yb,Zb,ac,bc,cc,dc,ec,fc,gc,hc,ic,jc,kc,lc,mc,nc,oc,pc,qc,rc,sc,tc,uc,vc,wc,xc,yc,zc,Ac,Bc,Cc,Dc,Ec,Fc,Gc,Hc,Ic,Jc,Kc,Lc,Mc,Nc,Oc,Pc,Qc,Rc,Sc,Tc,Uc,Vc,Wc,Xc,Yc,Zc,ad,bd,cd,dd,ed,fd,gd,hd,id,jd,kd,ld,md,nd,od,pd,qd,rd,sd,td,ud,vd,wd,xd,yd,zd,Ad,Bd,Cd,Dd,Ed,Fd,Gd,Hd,Id,Jd,Kd,Ld,Md,Nd,Od,Pd,Qd,Rd,Sd})end;g(p)end;w[b]=f(c)end end;u+=y.D elseif z==77 then if(j[y.A]==nil and 0 or 1)==bit32.rshift(y.aux,31)then u+=y.D else u+=1 end elseif z==78 then local a=y.aux;if((j[y.A]and 0 or 1)==(bit32.band(a,1)and 0 or 1))==bit32.rshift(a,31)then u+=y.D else u+=1 end elseif z==79 then local a=y.aux;local b=x[bit32.band(a,16777215)+1]assert(type(b)=="number","JUMPXEQKN encountered non-number constant!")local c=j[y.A]if bit32.rshift(a,31)==0 then u+=c==b and y.D or 1 else u+=c~=b and y.D or 1 end elseif z==80 then local a=y.aux;local b=x[bit32.band(a,16777215)+1]assert(type(b)=="string","JUMPXEQKS encountered non-string constant!")if((b==j[y.A])and 0 or 1)~=bit32.rshift(a,31)then u+=y.D else u+=1 end else error("Unsupported Opcode: "..y.opname.." op: "..z)end end end;local function b(...)local b=c(...)local d=d(m.maxstacksize)local f={len=0,list={}}e(b,1,m.numparams,0,d)if m.numparams<b.n then local a=m.numparams+1;local c=b.n-m.numparams;f.len=c;e(b,a,a+c-1,1,f.list)end;local b={}local e;if not a then e=c(j(r,b,d,m.protos,m.code,f))else e=c(true,r(b,d,m.protos,m.code,f))end;if e[1]then return table.unpack(e,2,e.n)else error(string.format("Fiu VM Error PC: %s Opcode: %s: \n%s",b.pc,b.name,e[2]),0)end end;return b end;return n(b,m)end;local rrr={luau_load=b,luau_newproto=l,luau_newmodule=k,luau_deserialize=q};return rrr.luau_load;end)()]==],
	AES = nil,
	AESCode = [==[(function()local function a(b)local c={}for d=0,255 do c[d]={}end;c[0][0]=b[1]*255;local e=1;for f=0,7 do for d=0,e-1 do for g=0,e-1 do local h=c[d][g]-b[1]*e;c[d][g+e]=h+b[2]*e;c[d+e][g]=h+b[3]*e;c[d+e][g+e]=h+b[4]*e end end;e=e*2 end;return c end;local i=a{0,1,1,0}local function j(self,k)local l,d,g=self.S,self.i,self.j;local m={}local n=string.char;for o=1,k do d=(d+1)%256;g=(g+l[d])%256;l[d],l[g]=l[g],l[d]m[o]=n(l[(l[d]+l[g])%256])end;self.i,self.j=d,g;return table.concat(m)end;local function p(self,q)local r=j(self,#q)local s={}local t=string.byte;local n=string.char;for d=1,#q do s[d]=n(i[t(q,d)][t(r,d)])end;return table.concat(s)end;local function u(self,v)local l=self.S;local g,w=0,#v;local t=string.byte;for d=0,255 do g=(g+l[d]+t(v,d%w+1))%256;l[d],l[g]=l[g],l[d]end end;function new(v)local l={}local s={S=l,i=0,j=0,generate=j,cipher=p,schedule=u}for d=0,255 do l[d]=d end;if v then s:schedule(v)end;return s end;return new end)()]==],
	Base64 = {
		Encode = function(a)local b=charset;return(a:gsub('.',function(c)local d,b='',c:byte()for e=8,1,-1 do d=d..(b%2^e-b%2^(e-1)>0 and'1'or'0')end;return d end)..'0000'):gsub('%d%d%d?%d?%d?%d?',function(c)if#c<6 then return''end;local f=0;for e=1,6 do f=f+(c:sub(e,e)=='1'and 2^(6-e)or 0)end;return b:sub(f+1,f+1)end)..({'','==','='})[#a%3+1]end,
		Decode = function(a)local b=charset;a=string.gsub(a,'[^'..b..'=]','')return a:gsub('.',function(c)if c=='='then return''end;local d,e='',b:find(c)-1;for f=6,1,-1 do d=d..(e%2^f-e%2^(f-1)>0 and'1'or'0')end;return d end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(c)if#c~=8 then return''end;local g=0;for f=1,8 do g=g+(c:sub(f,f)=='1'and 2^(8-f)or 0)end;return string.char(g)end)end
	},
	Base64Code = {
		Encode = [==[function(a)local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';return(a:gsub('.',function(c)local d,b='',c:byte()for e=8,1,-1 do d=d..(b%2^e-b%2^(e-1)>0 and'1'or'0')end;return d end)..'0000'):gsub('%d%d%d?%d?%d?%d?',function(c)if#c<6 then return''end;local f=0;for e=1,6 do f=f+(c:sub(e,e)=='1'and 2^(6-e)or 0)end;return b:sub(f+1,f+1)end)..({'','==','='})[#a%3+1]end]==],
		Decode = [==[function(a)local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';a=string.gsub(a,'[^'..b..'=]','')return a:gsub('.',function(c)if c=='='then return''end;local d,e='',b:find(c)-1;for f=6,1,-1 do d=d..(e%2^f-e%2^(f-1)>0 and'1'or'0')end;return d end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(c)if#c~=8 then return''end;local g=0;for f=1,8 do g=g+(c:sub(f,f)=='1'and 2^(8-f)or 0)end;return string.char(g)end)end]==]
	},
};

--Resources:
-- ~~Compiler: Yueliang(source, scriptname): luac string | Executor: FiOne(luac, env): function~~
-- Base64: Base64.Encode(data): string | Base64.Decode(data): string
-- "FiOneCode" loadstringable string
-- AES: AES(key) - and something
-- AESCode: src of aes
-- Base64Code: src of base64 Encode, Decode
--
function loaddata(name)
	return resources[name]
end

local compile = loaddata("Yueliang")
--local execute = loaddata("FiOne")

do
	--loadstring = function(contents, chunkname, env) -- wow custom loadstring
	--	local bytecode = compile(contents, chunkname or nil)
	--	local func = execute(bytecode, env or fenv(2))
	--	return func
	--end
	--resources.FiOne = loadstring("return " .. loaddata("AESCode"))()
	resources.AES = loadstring("return " .. loaddata("AESCode"))()
end

local _settings = { -- default options
	comment = "// CRYPTED", -- "--'comment'"
	variablecomment = "lol you have to stop trying to deobfuscate",
	cryptvarcomment = true, -- encrypt variablecomment with bytecode
	variablename = "CRYPTED", -- "local 'variablename' = 'variablecomment' or something"
}

local aes = loaddata("AES")
local base64 = loaddata("Base64")
local function aesenc(code, key)
	local state = aes(key)
	local unable = state:cipher(code)
	local able = base64.Encode(unable)
	return able
end

local function aesdec(code, key)
	local state = aes(key)
	local unable = base64.Decode(code)
	local result = state:cipher(unable)
	return result
end

local function genpass(l)
	local pass = ""
	for i = 1, l do
		local a = math.random(1,#morecharset)
		pass = pass .. morecharset:sub(a,a)
	end
	return pass
end

local h2b = {
	['0']='0000', ['1']='0001', ['2']='0010', ['3']='0011',
	['4']='0100', ['5']='0101', ['6']='0110', ['7']='0111',
	['8']='1000', ['9']='1001', ['A']='1010', ['B']='1011',
	['C']='1100', ['D']='1101', ['E']='1110', ['F']='1111'
}
local function d2b(n)
	return ('%X'):format(n):upper():gsub(".", h2b)
end
local function genIl(a)
	return d2b((a):byte(1,-1)):gsub("0","l"):gsub("1","I") 
end
local silentmode = climode and realargs.silent or false
if silentmode == false then
	print(
		"LuauObfuscator " .. obversion .. "\n" ..
		"Copyright (c) 2023 Reboy / M0dder" .. "\n" 
	)
end
M.crypt = function(srcfile, options)
	local detect = io.open("luau-"..curos..(curos == "win" and ".exe" or ""),"rb")
	if detect == nil then
		return error("Luau Binary has not found.")
	end
	detect:close()
	local srced = io.open(srcfile,"rb")
	local source = srced:read("*a")
	srced:close()
	if silentmode == false and #source >= 2000000 then
		print("WARNING: Your script seems too big, the process may be crashed or the code may be corrupted.")
	end
	options = options or {}
	for k,v in pairs(_settings) do
		if options[k] == nil then
			options[k] = v
		end
	end
	options.variablename = options.variablename:gsub('[%p%c%s]', '_')
	options.variablename = options.variablename:sub(1,1):gsub('[%d]','v'..options.variablename:sub(1,1)) .. options.variablename:sub(2)
	local varname = options.variablename
	local varcomment = options.cryptvarcomment and "\\"..table.concat({options.variablecomment:byte(1,-1)},"\\") or options.variablecomment
	local comment = options.comment

	-- f%d_%a -- fake
	-- c%d_%a -- real
	if not silentmode then print("Obfuscating | Code conversion...")end
	local succ, luac = pcall(function()
		return compile(srcfile)
	end)
	if succ == false then
		print("Luau Error")
		return error(luac)
	end
	collectgarbage()
	if not silentmode then print("Obfuscating | Encrypting...")end
	local r_key = "return(function()"
	local fv_z = ("local %s%s = \"%s\";"):format(varname, genIl("z"), varcomment)
	local f1_a = ("local %s%s"):format(varname, genIl("a"))
	local f2_b = ("local %s%s"):format(varname, genIl("b"))
	local f3_c = ("local %s%s"):format(varname, genIl("c"))
	local c1_d = ("local %s%s"):format(varname, genIl("d"))
	local f4_e = ("local %s%s"):format(varname, genIl("e"))
	local f5_f = ("local %s%s"):format(varname, genIl("f"))
	local f6_g = ("local %s%s"):format(varname, genIl("g"))
	local passkey = genpass(math.random(10,20))
	local encsrc = aesenc(base64.Encode(luac), passkey)
	local key64 = base64.Encode(passkey)
	collectgarbage()
	if not silentmode then print("Obfuscating | Code Building...")end
	local f4 = f4_e .. "=" .. ("'%s'"):format(base64.Encode(genpass(math.random(10,20))))
	local f5 = f5_f .. "=" .. ("'%s'"):format(varcomment)
	local f6 = f6_g .. "=" .. ("'%s'"):format(base64.Encode(genpass(math.random(10,20))))
	local c1 = c1_d .. "=" .. ("'%s'"):format("\\"..table.concat({key64:byte(1,-1)},"\\"))
	local fks = {f4,f5,f6,c1}
	local i_ = ("%s%s"):format(varname, genIl("i"))
	local c2_i_b64 = ("local %s"):format(i_) .. "=" .. loaddata("Base64Code").Decode
	local j_ = ("%s%s"):format(varname, genIl("j"))
	local c3_j_aes = ("local %s"):format(j_) .. "=" .. loaddata("AESCode")
	local k_ = ("%s%s"):format(varname, genIl("k"))
	local c4_k_fne = ("local %s"):format(k_) .. "=" .. loaddata("FiOneCode")
	local f7_h = [[function ]]..("%s%s"):format(varname, genIl("h"))..[[(a,b)local c=]]..i_..[[(a,b);local d=]]..f4_e:sub(7)..[[;return c,d end]]
	local f8_l = ("%s%s"):format(varname, genIl("h"))..("(%s,%d)"):format(f5_f:sub(7),math.random(314,31415))
	local m_ = ("%s%s"):format(varname, genIl("m"))
	local c4_m = ("local %s"):format(m_) .. "=" .. "function(a,b)" ..--a.64key,b.64src
		"local c="..j_.."("..i_.."(a))" ..
		"local d=c[\"\\99\\105\\112\\104\\101\\114\"](c,"..i_.."(b))" ..
		"return "..i_.."(d)" ..
		"end"
	local n_ = ("%s%s"):format(varname, genIl("n"))
	local bytedsrc = nil
	if encsrc:len() > 255 then -- handle lua byte library limit
		local chunkedbys = {}
		for i=1,#encsrc,255 do
			chunkedbys[#chunkedbys+1] = {encsrc:sub(i,i+255 - 1):byte(1,-1)}
		end
		bytedsrc = {}
		for i,v in pairs(chunkedbys) do
			for i1,v1 in pairs(v) do
				bytedsrc[#bytedsrc+1] = v1
			end
		end
	else
		bytedsrc = {encsrc:byte(1,-1)}
	end
	local c5res = "\\"..table.concat(bytedsrc,"\\")
	local c5_n = ("local %s"):format(n_) .. "="..("\"%s\""):format(c5res)
	local fenvhandle = "local fev=getfenv or function()return _ENV end"
	local f9_o = ("local %s%s"):format(varname, genIl("o")) .. "=" .. ("'%s%s%s'"):format(base64.Encode(genpass(math.random(10,20))),base64.Encode(genpass(math.random(10,20))),base64.Encode(genpass(math.random(10,20))))
	local c_end = ("return %s(%s(%s,%s),fev(0))()end)()"):format(k_,m_,(c1_d):sub(7),n_)--1.exe,2.c4,3.c4_a,4.c4_b
	if not silentmode then print("Obfuscated!")end
	return "--" .. comment .. "\n\n" ..
		r_key ..
		fv_z ..
		fv_z ..
		fv_z ..
		f1_a .. "=" .. ("%d"):format(math.random(111,31415)/100) .. ";" ..
		f2_b .. "=" .. ("%d"):format(math.random(111,31415)/100) .. ";" ..
		f3_c .. "=" .. ("%d"):format(math.pi) .. ";" ..
		c2_i_b64 ..  ";" ..
		f2_b .. "=" .. ("%d"):format(math.random(111,31415)/100) .. ";" ..
		c3_j_aes ..  ";" ..
		fenvhandle .. ";" ..
		c4_k_fne .. ";" ..
		fks[math.random(1,#fks)] .. ";" ..
		c5_n .. ";" ..
		fks[math.random(1,#fks)] .. ";" ..
		fks[math.random(1,#fks)] .. ";" ..
		c4_m .. ";" ..
		fks[math.random(1,#fks)] .. ";" ..
		c1 .. ";" ..
		fks[math.random(1,#fks)] .. ";" ..
		f9_o .. ";" ..
		f7_h .. ";" ..
		c_end
end

if climode == true then
	local detect = io.open("luau-"..curos..(curos == "win" and ".exe" or ""),"rb")
	if detect == nil then
		print("ERROR: A Luau Executable not found, check current directory has '".."luau-"..curos..(curos == "win" and ".exe" or "").."'.")
		return
	end
	detect:close()
	if silentmode == false and not realargs.force then
		local existfile = io.open(realargs.output or "output.lua","r")
		if existfile ~= nil then
			io.close(existfile)
			print("Output file is exist: " .. (realargs.output or "output.lua"))
			io.write("Would you like to overwrite it? (y/N) ")
			local answer = io.read()
			if answer:lower():sub(1,1) ~= "y" then
				print("Cancelled")
				return
			end
		end
	end
	local rsuccess, readdfile, rerr = pcall(function()
		return io.open(realargs.source, "rb")
	end)
	if rsuccess == false or readdfile == nil then
		print("File (source file) Reading Error: " .. (rsuccess == false and readdfile or rerr or "Unknown"))
		return
	end
	if not silentmode then print(("Selected source file to \"%s\"."):format(realargs.source))end
	local wsuccess, wdfile, werr = pcall(function()
		return io.open(realargs.output or "output.lua", "w")
	end)
	if wsuccess == false or wdfile == nil then
		readdfile:close()
		print("File (output file) Writing Error: " .. (wsuccess == false and wdfile or werr or "Unknown"))
		return
	end
	if not silentmode then print(("Selected output file to \"%s\"."):format(realargs.output or "output.lua"))end
	local clisettings = {
		comment = realargs.comment or _settings.comment, -- --comment "string"
		variablecomment = realargs.varcomm or _settings.variablecomment, -- --varcomm "string"
		cryptvarcomment = realargs.cryptvarcomm or false, -- --cryptvarcomm
		variablename = realargs.varname or _settings.variablename, -- --varname "string"
	}
	collectgarbage()
	local starttime = os.clock()
	if not silentmode then print("Starting obfuscation.")end
	local kb = M.crypt(realargs.source,clisettings) -- you need more memory if you get error at here
	if not silentmode then print(("Finished obfuscation in %f seconds."):format(os.clock() - starttime))end
	readdfile:close()
	wdfile:write(kb)
	wdfile:close()
	kb = nil
	if not silentmode then print(("Obfuscated code are written to \"%s\"."):format(realargs.output or "output.lua"))end
	if not silentmode then print("All done.")end
	if realargs.openfile then
		os.execute((package.config:sub(1,1) == "\\" and "" or (os.getenv("EDITOR") .. " "))..(realargs.output or "output.lua") .. " &")
	end
	return
end

return setmetatable(M, {
	__call = function(self, source, options)
		return self.crypt(source, options)
	end,
})
