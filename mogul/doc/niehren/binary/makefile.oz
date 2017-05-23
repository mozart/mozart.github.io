makefile(%% contribution
	 provides   : ['value.ozf'
		       'test.oz' ]
	 lib        :['n-ary.ozf'
		      'string.ozf'
		      'value.ozf'
		      'test.oz'
		     ]
	 %% package properties
	 mogul      :'mogul:/niehren/binary'
	 author     : 'mogul:/niehren/joachim' 
	 uri        :'x-ozlib://base/binary'
	 version    : '0.1.2'
	 categories :['lib']
	 %% documentation
	 blurb      :'Conversion of Oz values to binaries and back.'
	 info_html  : 'This package is no more supported.'
	 doc        : ['makefile.oz']
	)
