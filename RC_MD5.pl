#!/usr/bin/perl
$ver = "01";
$dbgtmr = "1"; #Son denemeyi gosterme aralıgı
 
if ($dbgtmr<=0){ die "Set dbgtmr to a value >=1 !\n";};
use Digest::MD5 qw(md5_hex);
use Time::HiRes qw(gettimeofday);
 
if ($ARGV[0]=~"a") {
$alpha = "abcdefghijklmnoprstuvwxyzq";}
if ($ARGV[0]=~"A") {
$alpha = $alpha. "ABCDEFGHIJKLMNOPRSTUVWXYZQ";}
if ($ARGV[0]=~"d") {
$alpha = $alpha."1234567890";}
if ($ARGV[0]=~"x") {
$alpha = $alpha. "!\"\$%&/()=?-.:\\*'-_:.;,";}
 
if ($alpha eq "" or $ARGV[3] eq "") {usage();};
if (length($ARGV[3]) != 32) { die "Maalesef Bu MD5 Cozulemedi!\n";};
 
print "Denemeler Icin secilen karakter seti:  '$alpha\'\n";
print "Cozumlenecek MD5 '$ARGV[3]'...\n";
 
for (my $t=$ARGV[1];$t<=$ARGV[2];$t++){
crack ($t);
}
 
sub usage{
print "MD5 Cozumleyici \n";
print "Ahmet Aktas\n";
print "twitter.com/RetiredCoder";
print "MD5 Cozumleme Prospektus;\n";
print "./rcmd5 <KarakterSeti> <MinDeger> <MaxDeger> <MD5>\n";
print " Secimlerinizi yandaki ornek gibi yapiniz: => [aAdx]\n";
print " a = {'a','b','c',...}\n";
print " A = {'A','B','C',...}\n";
print " d = {'1','2','3',...}\n";
print " x = {'!','\"',' ',...}\n";
print "Cozumlemek icin bir ornek\n";
print "./rcmd5.pl ad 1 3 900150983cd24fb0d6963f7d28e17f72\n";
print "       Bu ornek; 1,2,3 haneli olarak denenecek sifreleri yalnizca kucuk harfler ile dener. \n";
print "./rcmd5.pl aA 3 3 900150983cd24fb0d6963f7d28e17f72\n";
print "       Bu ornek; 3 haneli olarak denenecek sifreleri yalnizca buyuk ve kucuk harfler ile dener. \n";
print "./rcmd5.pl aAdx 1 10 900150983cd24fb0d6963f7d28e17f72\n";
print "       Bu ornek; min.1 max.10 haneli olarak denenecek sifreleri kucuk, buyuk, ozel karakter ve rakam olarak dener.\n";
die "Cevap Bekleniyor\n";
}
 
sub crack{
$CharSet = shift;
@RawString = ();
for (my $i =0;$i<$CharSet;$i++){ $RawString[i] = 0;}
$Start = gettimeofday();
do{
  for (my $i =0;$i<$CharSet;$i++){
   if ($RawString[$i] > length($alpha)-1){
    if ($i==$CharSet-1){
    print "
..........................................................................................................................
|   ######   #######  ######## ##     ## ##     ## ##       ######## ##    ## ######## ##     ## ######## ########  #### |
|  ##    ## ##     ##      ##  ##     ## ###   ### ##       ##       ###   ## ##       ###   ### ##       ##     ##  ##  |
|  ##       ##     ##     ##   ##     ## #### #### ##       ##       ####  ## ##       #### #### ##       ##     ##  ##  |
|  ##       ##     ##    ##    ##     ## ## ### ## ##       ######   ## ## ## ######   ## ### ## ######   ##     ##  ##  |
|  ##       ##     ##   ##     ##     ## ##     ## ##       ##       ##  #### ##       ##     ## ##       ##     ##  ##  |
|  ##    ## ##     ##  ##      ##     ## ##     ## ##       ##       ##   ### ##       ##     ## ##       ##     ##  ##  |
|   ######   #######  ########  #######  ##     ## ######## ######## ##    ## ######## ##     ## ######## ########  #### |
|........................................................................................................................|
	
	MD5 [$hash] $CharSet haneli karakter setinde basarili!  => $ret
	MD5 [$hash] $CharSet haneli karakter setinde basarili!  => $ret
	MD5 [$hash] $CharSet haneli karakter setinde basarili!  => $ret";
    $cnt=0;
    return false;
   }
   $RawString[$i+1]++;
   $RawString[$i]=0;
   }
  }
##################################################  #
   $ret = "";
   for (my $i =0;$i<$CharSet;$i++){ $ret = $ret . substr($alpha,$RawString[$i],1);}
   $hash = md5_hex($ret);
   $cnt++;
   $Stop = gettimeofday();
   if ($Stop-$Start>$dbgtmr){
    $cnt = int($cnt/$dbgtmr);
    print "$cnt hashes\\second.\tLast Pass '$ret\'\n";
    $cnt=0;
    $Start = gettimeofday();
   }
            print "$ARGV[3] != $hash ($ret)\n";
   if ($ARGV[3] eq $hash){
    die "...............................................................................................
|   ######   #######  ######## ##     ## ##     ## ##       ######## ##    ## ########  ####   |
|  ##    ## ##     ##      ##  ##     ## ###   ### ##       ##       ###   ## ##     ##  ##    |
|  ##       ##     ##     ##   ##     ## #### #### ##       ##       ####  ## ##     ##  ##    |     
|  ##       ##     ##    ##    ##     ## ## ### ## ##       ######   ## ## ## ##     ##  ##    |
|  ##       ##     ##   ##     ##     ## ##     ## ##       ##       ##  #### ##     ##  ##    |
|  ##    ## ##     ##  ##      ##     ## ##     ## ##       ##       ##   ### ##     ##  ##    |                                   
|   ######   #######  ########  #######  ##     ## ######## ######## ##    ## ########  ####   |
|..............................................................................................| 
|      MD5 [$hash] $CharSet haneli karakter setinde basarili!  => $ret                     
|      MD5 [$hash] $CharSet haneli karakter setinde basarili!  => $ret                      
|      MD5 [$hash] $CharSet haneli karakter setinde basarili!  => $ret"   
   } 
   
   
##################################################  #
  #checkhash($CharSet)."\n";
 
  $RawString[0]++;
}while($RawString[$CharSet-1]<length($alpha));
}
 
sub checkhash{
$CharSet = shift;
$ret = "";
for (my $i =0;$i<$CharSet;$i++){ $ret = $ret . substr($alpha,$RawString[$i],1);}
$hash = md5_hex($ret);
$cnt++;
$Stop = gettimeofday();
if ($Stop-$Start>$dbgtmr){
  $cnt = int($cnt/$dbgtmr);
  print "$cnt hashes\\second.\tLast Pass '$ret\'\n";
  $cnt=0;
  $Start = gettimeofday();
}
 
if ($ARGV[3] eq $hash){
  die "\n***Parola Cozumlendi! => $ret\n ";
  
}
 
}