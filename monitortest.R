# monitor a file in real time


snapshot <- fileSnapshot(".", md5sum=TRUE)

while(TRUE) {
	ch <- changedFiles(snapshot)$changes
	if(any(ch)) {
		snapshot <- fileSnapshot(".", md5sum=TRUE)
		print(ch)
	}
}

