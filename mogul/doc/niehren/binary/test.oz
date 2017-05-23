

declare Modules = ['x-ozlib:/base/binary/string.ozf'
		   'x-ozlib:/base/binary/value.ozf']


declare Modules = ['x-ozlib:/base/binary/string.ozf'
		   'x-ozlib:/base/binary/value.ozf']

declare [String Value] = {Link Modules}

declare Str =  "der bescheuerte kodierer"
declare Val =  der(bescheuerte:kodierer)

{Inspect Str}
{Inspect {String.decode {String.encode Str}}}

{Inspect Val}
{Inspect {Value.decode {Value.encode Val}}}

