declare Modules = ['x-ozlib://niehren/assignment.ozf']
declare [A] = {Module.link Modules}
declare 'export'(new:NewAss
		 newVarAss:NewVarAss
		 newAtomAss:NewAtomAss ...) = A

declare VA = {NewAtomAss x 4}

declare Term = a(1 3 2)
{Inspect {VA.substitute Term}} 
{Inspect VA}
