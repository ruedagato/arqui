Dim FileName, Find, ReplaceWith, FileContents, dFileContents
Find         = "yyparse ()" & VbCrLf & "    ;" & VbCrLf & "#endif"
ReplaceWith  = "yyparse ()" & VbCrLf & "     " & VbCrLf & "#endif"
FileName     = WScript.Arguments(0)

'Read source text file
FileContents = GetFile(FileName)

'replace all string In the source file
dFileContents = replace(FileContents, Find, ReplaceWith, 1, -1, 1)

'Compare source And result
if dFileContents <> FileContents Then
  'write result If different
  WriteFile FileName, dFileContents

   If Len(ReplaceWith) <> Len(Find) Then 'Can we count n of replacements?
    Wscript.Echo _
    ( (Len(dFileContents) - Len(FileContents)) / (Len(ReplaceWith)-Len(Find)) ) & _
    " replacements."
  End If
Else
  Wscript.Echo "Searched string Not In the source file"
End If

'Read text file
function GetFile(FileName)
  If FileName<>"" Then
    Dim FS, FileStream
    Set FS = CreateObject("Scripting.FileSystemObject")
      on error resume Next
      Set FileStream = FS.OpenTextFile(FileName)
      GetFile = FileStream.ReadAll
  End If
End Function

'Write string As a text file.
function WriteFile(FileName, Contents)
  Dim OutStream, FS

  on error resume Next
  Set FS = CreateObject("Scripting.FileSystemObject")
    Set OutStream = FS.OpenTextFile(FileName, 2, True)
    OutStream.Write Contents
End Function
