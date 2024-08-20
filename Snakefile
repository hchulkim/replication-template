rule example:
	input:
		script = ".bash"
	output:
		archive = "..."
	params:
		file = "..."
	shell:
		"""
		{input.script}{params.file}
		"""
