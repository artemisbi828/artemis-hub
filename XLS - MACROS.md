
> [!steps]
> 1. **Enable Developer Tab** (if not visible):
>     
>     - Right-click on any ribbon tab → `Customize the Ribbon`
>     - Check the box for `Developer` on the right side
>     - Click `OK`
> 2. **Record Macro:**
>     
>     - Click `Developer` tab
>     - Click `Record Macro` button
>     - Store macro in: `Personal Macro Workbook`
>     - Click `OK`
>     - Immediately click `Stop Recording` (same button)
> 
> 3. Press `ALT + F11` (VBA Editor)
> 4. In the menu: `File` → `Import File...`
> 5. Or just go to `Insert` → `Module` in any workbook
> 6. Paste the VBA code
> 7. Press `ALT + F8` to assign CTRL+T
> 
> Now assign it to CTRL+T:
> 
> 8. Press `ALT + F8`
> 9. Select `CreateTableWithNullCleanup`
> 10. Click `Options`
> 11. Shortcut key: `t`
> 12. Click `OK`

---
# Create Table
Need macro for local key binding.
```
Sub CreateTableWithNullCleanup()
    Dim rng As Range
    Dim tbl As ListObject
    
    ' Use current selection
    Set rng = Selection
    
    ' Replace "NULL" with empty strings in selection
    rng.Replace What:="NULL", Replacement:="", LookAt:=xlWhole, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    
    ' Create table with headers (xlYes = first row is header)
    On Error Resume Next
    Set tbl = ActiveSheet.ListObjects.Add(xlSrcRange, rng, , xlYes)
    On Error GoTo 0
    
    ' Optional: Apply a table style
    If Not tbl Is Nothing Then
        tbl.TableStyle = "TableStyleMedium2"
    End If
End Sub
```

Recorded Macro 
```
Sub create_table()
'
' create_table Macro
'
' Keyboard Shortcut: Ctrl+Shift+T
'
    ActiveSheet.ListObjects.Add(xlSrcRange, Range("$C$9:$D$17"), , xlYes).Name = _
        "Table6"
    Range("D15").Select
    ActiveCell.FormulaR1C1 = "Null"
    Range("Table6").Select
    Range("D16").Activate
    Selection.Replace What:="NULL", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False, FormulaVersion:=xlReplaceFormula2
End Sub

```