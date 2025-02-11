'********** Copyright 2017 Roku Inc.  All Rights Reserved. **********
Function dump_response(list as object) as void
	for each obj in list
		for each element in obj
		    print toStr(element) + " = " + toStr(obj.lookup(element))
		end for
	end for
End Function

Function AnyToString(any As Dynamic) As dynamic
    if any = invalid return "invalid"
    if isstr(any) return any
    if isint(any) return itostr(any)
    if isbool(any)
        if any = true return "true"
        return "false"
    endif
    if isfloat(any) return Str(any)
    if type(any) = "roTimespan" return itostr(any.TotalMilliseconds()) + "ms"
    return invalid
End Function

Function tostr(any)
    ret = AnyToString(any)
    if ret = invalid ret = type(any)
    if ret = invalid ret = "unknown" 'failsafe
    return ret
End Function

Function isstr(obj as dynamic) As Boolean
    return obj <> invalid and  GetInterface(obj, "ifString") <>invalid
End Function

Function isint(obj as dynamic) As Boolean
    return obj <> invalid and GetInterface(obj, "ifInt") <> invalid
End Function

Function isbool(obj as dynamic) As Boolean
    if obj = invalid return false
    if GetInterface(obj, "ifBoolean") = invalid return false
    return true
End Function

Function isfloat(obj as dynamic) As Boolean
    if obj = invalid return false
    if GetInterface(obj, "ifFloat") = invalid return false
    return true
End Function

Function itostr(i As Integer) As String
    str = Stri(i)
    return strTrim(str)
End Function


'******************************************************
'Trim a string
'******************************************************
Function strTrim(str As String) As String
    st=CreateObject("roString")
    st.SetString(str)
    return st.Trim()
End Function
