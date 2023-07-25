#reproduce alternative

MAX_ITER=5
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Master-worker experiments
cd $SCRIPT_DIR/build/examples/masterworker
[ ! -d logs ] && mkdir logs

echo "Running master-worker experiments..."
for WORKERS in 2 4 7
do
	echo "Example with $WORKERS workers..."
	for ITER in $(seq 1 $MAX_ITER)
	do
		echo "Running iteration $ITER..."
		dff_run -V -p TCP -f masterworker_${WORKERS}.json ./masterworker_dist 1 20 5 ../../../data ${WORKERS} 2>&1 > logs/masterworker_${WORKERS}_${ITER}
	done
	echo "Mean execution time for master-worker with $WORKERS workers : " $(cat logs/masterworker_$WORKERS_* | grep "Elapsed time" | awk '{ sum += $3; n++ } END { if (n > 0) print sum / n; }')
done