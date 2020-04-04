unit HangMan01;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Bevel1: TBevel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBox3: TGroupBox;
    Button31: TButton;
    Button32: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    Label9: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  dico: array[1..32] of string;
  bon,codesecret,compt,compt2,fatal,hardness,mauvais,nbessais,onepass,score,tirage,totalbon,youcan:integer;
  difleveldico,fichdicoload,fichdicosave,fichuserload,fichusersave,intermed,mot,nouveaumot,playerhiscore,playerleague,playername,testvalid,upnouveaumot:string;
  dicotoload,dicotosave,usertoload,usertosave:textfile;

implementation

{$R *.DFM}

procedure TForm1.Button2Click(Sender: TObject);
begin
showmessage('Avant de quitter, sauvez votre profil joueur !');
fichusersave:='';savedialog1.execute;
fichusersave:=savedialog1.filename;
if (fichusersave<>'') and (not fileexists(fichusersave)) then
begin
assignfile(usertosave,fichusersave);
rewrite(usertosave);writeln(usertosave,'[PendUserFile]');
writeln(usertosave,inputbox('Nouveau profil joueur','NOM :',playername));
writeln(usertosave,score);
if score<=200 then writeln(usertosave,'1');
if (score>200) and (score<=400) then writeln(usertosave,'2');
if (score>400) and (score<=600) then writeln(usertosave,'3');
if score>600 then writeln(usertosave,'4');
showmessage('OK !');closefile(usertosave);
end
else
if fileexists(fichusersave) then
begin
assignfile(usertosave,fichusersave);erase(usertosave);rewrite(usertosave);
writeln(usertosave,'[PendUserFile]');writeln(usertosave,inputbox('Sauvegarde profil joueur','NOM :',''));
if score>strtoint(playerhiscore) then playerhiscore:=inttostr(score);
writeln(usertosave,playerhiscore);
if strtoint(playerhiscore)<=200 then writeln(usertosave,'1');
if (strtoint(playerhiscore)>200) and (strtoint(playerhiscore)<=400) then writeln(usertosave,'2');
if (strtoint(playerhiscore)>400) and (strtoint(playerhiscore)<=600) then writeln(usertosave,'3');
if strtoint(playerhiscore)>600 then writeln(usertosave,'4');closefile(usertosave);
end;
close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
randomize;edit1.text:='';edit2.text:='';onepass:=0;progressbar1.position:=0;
fatal:=0;codesecret:=0;score:=0;youcan:=0;upnouveaumot:='';hardness:=1;
totalbon:=0;nouveaumot:='';bon:=0;mauvais:=0;label2.Caption:='0';
playername:='NEW';playerhiscore:='0';playerleague:='1';label6.caption:='Beginners';
dico[1]:='ARBRE';dico[2]:='ABRI';dico[3]:='ABRICOT';dico[4]:='BIJOU';
dico[5]:='BISOU';dico[6]:='BALLON'; dico[7]:='BOL';dico[8]:='COLLE';
dico[9]:='CIMENT';dico[10]:='DAMIER';dico[11]:='DORTOIR';dico[12]:='DISTANT';
dico[13]:='EAU';dico[14]:='ETANG';dico[15]:='EPURE';dico[16]:='FABULEUX';
dico[17]:='FERMIER';dico[18]:='FUNANBULE';dico[19]:='GOGOL';
dico[20]:='GUE';dico[21]:='HABIT';dico[22]:='HALLEBARDE';dico[23]:='HAUT';
dico[24]:='IGNARE';dico[25]:='JOYEUX';dico[26]:='LIMACE';
dico[27]:='MOTARD';dico[28]:='NOUNOURS';dico[29]:='OEIL';
dico[30]:='PARTENAIRE';dico[31]:='STATUE';dico[32]:='WWWWXXXYYYYZZZZ';
tirage:=random(32)+1;
for compt:=1 to length(dico[tirage]) do
edit1.text:=edit1.text+' _';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
randomize;progressbar1.position:=0;score:=0;totalbon:=0;fatal:=0;edit1.text:='';edit2.text:='';label2.Caption:='0';
if youcan=0 then
begin
dico[1]:='ARBRE';dico[2]:='ABRI';dico[3]:='ABRICOT';dico[4]:='BIJOU';
dico[5]:='BISOU';dico[6]:='BALLON'; dico[7]:='BOL';dico[8]:='COLLE';
dico[9]:='CIMENT';dico[10]:='DAMIER';dico[11]:='DORTOIR';dico[12]:='DISTANT';
dico[13]:='EAU';dico[14]:='ETANG';dico[15]:='EPURE';dico[16]:='FABULEUX';
dico[17]:='FERMIER';dico[18]:='FUNANBULE';dico[19]:='GOGOL';
dico[20]:='GUE';dico[21]:='HABIT';dico[22]:='HALLEBARDE';dico[23]:='HAUT';
dico[24]:='IGNARE';dico[25]:='JOYEUX';dico[26]:='LIMACE';
dico[27]:='MOTARD';dico[28]:='NOUNOURS';dico[29]:='OEIL';
dico[30]:='PARTENAIRE';dico[31]:='STATUE';dico[32]:='WWWWXXXYYYYZZZZ';
end;
tirage:=random(32)+1;
for compt:=1 to length(dico[tirage]) do
edit1.text:=edit1.text+' _';
end;

procedure TForm1.Button29Click(Sender: TObject);
begin
fichdicoload:='';opendialog1.execute;fichdicoload:=opendialog1.filename;
if (fichdicoload<>'') and (fileexists(fichdicoload)) then
begin
hardness:=0;assignfile(dicotoload,fichdicoload);reset(dicotoload);readln(dicotoload,testvalid);
if (testvalid='[PendFile1]') or (testvalid='[PendFile2]') or (testvalid='[PendFile3]') or (testvalid='[PendFile4]') then
   begin
   if testvalid='[PendFile1]' then
      begin
      showmessage('Niveau : débutant');hardness:=1;end;
      if testvalid='[PendFile2]' then
      begin
      showmessage('Niveau : amateur');hardness:=2;end;
      if testvalid='[PendFile3]' then
      begin
      showmessage('Niveau : confirmé');hardness:=3;end;
      if testvalid='[PendFile4]' then
      begin
      showmessage('Niveau : KILLER !!!');hardness:=4;end;
                          if (strtoint(playerleague)>=hardness) and (hardness<>0) then
                          begin
                          randomize;totalbon:=0;progressbar1.position:=0;fatal:=0;edit1.text:='';edit2.text:='';label2.caption:='0';
                          for compt:=2 to 33 do readln(dicotoload,dico[compt-1]);
                          tirage:=random(32)+1;for compt2:=1 to length(dico[tirage]) do edit1.text:=edit1.text+' _';
                          showmessage('Le nouveau dico est chargé !');youcan:=1;closefile(dicotoload);
                          end
                          else
                          showmessage('Vous ne faites pas partie de la bonne league !');end
else
begin showmessage('Ce fichier n''est pas valide !');closefile(dicotoload);end;end
else
showmessage('Ce fichier n''est pas valide !');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
edit2.text:='A';
onepass:=1;
codesecret:=0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
edit2.text:='Z';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
edit2.text:='E';
onepass:=1;
if codesecret=2 then
showmessage('AMIGA RuL3Z 4nD PC 5uXX ;-)');
codesecret:=0;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
edit2.text:='R';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
edit2.text:='T';
onepass:=1;
codesecret:=1;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
edit2.text:='Y';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
edit2.text:='U';
onepass:=1;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
edit2.text:='I';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
edit2.text:='O';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
edit2.text:='P';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
edit2.text:='Q';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
edit2.text:='S';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
edit2.text:='D';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
edit2.text:='F';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
edit2.text:='G';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
edit2.text:='H';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
edit2.text:='J';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
edit2.text:='K';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
edit2.text:='L';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
edit2.text:='M';
onepass:=1;
if codesecret=1 then
codesecret:=2;
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
edit2.text:='W';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
edit2.text:='X';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
edit2.text:='C';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
edit2.text:='V';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button27Click(Sender: TObject);
begin
edit2.text:='B';
onepass:=1;codesecret:=0;
end;

procedure TForm1.Button28Click(Sender: TObject);
begin
edit2.text:='N';
onepass:=1;codesecret:=0;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
if (onepass=1) then
begin
onepass:=0;mot:=dico[tirage];
for compt:=1 to length(dico[tirage]) do
begin
if (mot[compt]=edit2.text) and (mot[compt]<>edit1.text[compt*2]) then
begin
bon:=bon+1;totalbon:=totalbon+1;intermed:=edit1.text;statusbar1.simpletext:='Bien !';
intermed[compt*2]:=mot[compt];edit1.text:=intermed;
end;end;
if bon=0 then begin mauvais:=1;fatal:=fatal+1;progressbar1.position:=progressbar1.position+10;statusbar1.simpletext:='Pas bien ;-)';end;
score:=((score+(bon*10))-(mauvais*5));label2.caption:=inttostr(score);
bon:=0;mauvais:=0;
if score<=200 then label6.caption:='Beginners';
if (score>200) and (score<=400) then label6.caption:='Knights';
if (score>400) and (score<=600) then label6.caption:='Kings';
if score>600 then label6.caption:='Gods';
if totalbon=length(dico[tirage]) then
begin
statusbar1.simpletext:='Ouf !!';
showmessage('Vous avez trouvé le mot !');
randomize;totalbon:=0;fatal:=0;edit1.text:='';edit2.text:='';progressbar1.position:=0;tirage:=random(32)+1;
for compt2:=1 to length(dico[tirage]) do
edit1.text:=edit1.text+' _';
end;
if fatal=10 then
begin
statusbar1.simpletext:='Dommage :-)';
showmessage('PENDU !');
randomize;score:=0;totalbon:=0;fatal:=0;edit1.text:='';edit2.text:='';
label2.Caption:='0';progressbar1.position:=0;tirage:=random(32)+1;
for compt:=1 to length(dico[tirage]) do
edit1.text:=edit1.text+' _';
end;end;

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
edit2.text:='';
end;

procedure TForm1.Button30Click(Sender: TObject);
begin
showmessage('Vous allez créer un nouveau dico de 32 mots !');fichdicosave:='';
savedialog1.execute;
fichdicosave:=savedialog1.FileName;
if (fichdicosave<>'') and (not fileexists(fichdicosave)) then
begin
assignfile(dicotosave,fichdicosave);rewrite(dicotosave);
repeat
difleveldico:=inputbox('Nouveau dictionnaire','Niveau : 1 (Beginners), 2 (Knights), 3 (Kings) ou 4 (Gods) ?','');
until (difleveldico='1') or (difleveldico='2') or (difleveldico='3') or (difleveldico='4');
writeln(dicotosave,'[PendFile'+difleveldico+']');
for compt:=1 to 32 do
begin
nouveaumot:=inputbox('Nouveau dictionnaire','Mot n°'+inttostr(compt),'');
upnouveaumot:='';
for compt2:=1 to length(nouveaumot) do
upnouveaumot:=upnouveaumot+upcase(nouveaumot[compt2]);
writeln(dicotosave,upnouveaumot);
end;
showmessage('Dictionnaire crée !');closefile(dicotosave);
end
else
showmessage('Erreur de nom de fichier !');
end;

procedure TForm1.Button31Click(Sender: TObject);
begin
showmessage('Sauvez votre profil joueur !');
fichusersave:='';savedialog1.execute;
fichusersave:=savedialog1.filename;
if (fichusersave<>'') and (not fileexists(fichusersave)) then
begin
assignfile(usertosave,fichusersave);
rewrite(usertosave);writeln(usertosave,'[PendUserFile]');
writeln(usertosave,inputbox('Nouveau profil joueur','NOM :',playername));
writeln(usertosave,score);
if score<=200 then writeln(usertosave,'1');
if (score>200) and (score<=400) then writeln(usertosave,'2');
if (score>400) and (score<=600) then writeln(usertosave,'3');
if score>600 then writeln(usertosave,'4');
showmessage('OK !');closefile(usertosave);
end
else
if fileexists(fichusersave) then
begin
assignfile(usertosave,fichusersave);erase(usertosave);rewrite(usertosave);
writeln(usertosave,'[PendUserFile]');writeln(usertosave,inputbox('Sauvegarde profil joueur','NOM :',''));
if score>strtoint(playerhiscore) then playerhiscore:=inttostr(score);
writeln(usertosave,playerhiscore);
if strtoint(playerhiscore)<=200 then writeln(usertosave,'1');
if (strtoint(playerhiscore)>200) and (strtoint(playerhiscore)<=400) then writeln(usertosave,'2');
if (strtoint(playerhiscore)>400) and (strtoint(playerhiscore)<=600) then writeln(usertosave,'3');
if strtoint(playerhiscore)>600 then writeln(usertosave,'4');closefile(usertosave);
end;
opendialog1.execute;
fichuserload:='';fichuserload:=opendialog1.filename;
if fileexists(fichuserload) then
begin
assignfile(usertoload,fichuserload);reset(usertoload);readln(usertoload,testvalid);
if testvalid='[PendUserFile]' then
begin
randomize;totalbon:=0;fatal:=0;youcan:=1;bon:=0;mauvais:=0;progressbar1.position:=0;
tirage:=random(32)+1;edit1.text:='';edit2.text:='';label2.caption:='0';
readln(usertoload,playername);readln(usertoload,playerhiscore);score:=strtoint(playerhiscore);
label4.caption:=playername;label8.caption:=playerhiscore;readln(usertoload,playerleague);
label6.caption:='inconnue';
if strtoint(playerleague)=1 then label6.caption:='Beginners';
if strtoint(playerleague)=2 then label6.caption:='Knights';
if strtoint(playerleague)=3 then label6.caption:='Kings';
if strtoint(playerleague)=4 then label6.caption:='Gods';
closefile(usertoload);showmessage('Profil joueur chargé !');
for compt2:=1 to length(dico[tirage]) do edit1.text:=edit1.text+' _';
end
else
begin
showmessage('Ce fichier n''est pas valide !');closefile(usertoload);
end;
end
else
showmessage('Ce profil joueur n''existe pas !');
end;

procedure TForm1.Button32Click(Sender: TObject);
begin
fichusersave:='';savedialog1.execute;
fichusersave:=savedialog1.filename;
if (fichusersave<>'') and (not fileexists(fichusersave)) then
begin
assignfile(usertosave,fichusersave);
rewrite(usertosave);writeln(usertosave,'[PendUserFile]');
writeln(usertosave,inputbox('Nouveau profil joueur','NOM :',''));
writeln(usertosave,score);
if score<=200 then writeln(usertosave,'1');
if (score>200) and (score<=400) then writeln(usertosave,'2');
if (score>400) and (score<=600) then writeln(usertosave,'3');
if score>600 then writeln(usertosave,'4');
showmessage('OK !');closefile(usertosave);
end
else
showmessage('Erreur de nom de fichier !');
end;

end.
