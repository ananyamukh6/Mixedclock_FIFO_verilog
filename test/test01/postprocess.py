#golden output

lines = open('out_temp.txt').readlines()
f = open('out.txt', 'w')
for lineNum in range(len(lines)):
	line = lines[lineNum]
	timeStamp = line.split('-')[0]
	pop = line.split('pop:')[1].split(',')[0]
	full = line.split('full:')[1].split(',')[0]
	empty = line.split('empty:')[1].split(',')[0]
	data_in = line.split('data_in:')[1].split(',')[0]
	data_out = line.split('data_out:')[1].split(',')[0]
	buffer = line.split('buffer:')[1].split(';')[0]
	f.write(str(timeStamp) + ' ' + str(pop) + ' ' + str(full) + ' '+ str(empty) + ' ' + str(data_in) + ' ' + str(data_out) + ' ' + str(buffer))
f.close()

