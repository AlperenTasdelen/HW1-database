run:
	./run2.sh
	./pushtables.sh

clean:
	./droptables.sh

task1:
	make run
	psql -U alperentasdelen -d postgres -f task2_1.sql -o result1.csv -A -F ','