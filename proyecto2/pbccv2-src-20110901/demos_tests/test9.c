// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of BitWise operations (|, &, ^) (for pBlazeIDE), problem with NOT_OP
// In addition, test of the modulo operation.

void main()
{
  volatile char c = 1;
  c = !c;
  c = 0;
  c = !c;
  c = c && c;
  c = c || c;
  c = 29;
  c = c % 13;
}
