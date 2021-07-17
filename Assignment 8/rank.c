
void compute_ranks(float *F, int N, int *R, float *avg, float *passing_avg, int *num_passed) {
    int i, j;

    //temporary variables since they are easier to access than the pointers

    int tmp_num_passed = 0;
    float tmp_avg = 0.0;
    float tmp_passing_avg = 0.0;
    int tmp_R[N];			// R[N] is not an array that we use alot so creating a tmp here is faster than accessing the memory directly


	//     compute ranks
       	for (i = 0; i < N-1; i+=2) {
	//init ranks does not does not do anything complex to need its own loop
		tmp_R[i] = 1;
		tmp_R[i+1] = 1;

		for(j = 0; j < N; ++j){
			if(F[i] < F[j])
				tmp_R[i] += 1;
			if(F[i+1] < F[j])
				tmp_R[i+1] += 1;
		}

	//compute averages can bu used inside this loop as well since it will only use the current i not anything else
		tmp_avg += (F[i] + F[i+1]);

		if (F[i] >= 50.0){
			tmp_passing_avg += F[i];
			++tmp_num_passed;
      		}

               if (F[i+1] >= 50.0){
                        tmp_passing_avg += F[i+1];
                        ++tmp_num_passed;
                }


		R[i] = tmp_R[i];
		R[i+1] = tmp_R[i+1];
        }

	// check for div by 0
 	if (N > 0) tmp_avg /= (float) N;				// it is faster when it is float
	if (tmp_num_passed) tmp_passing_avg /= (float) tmp_num_passed;

	*avg = tmp_avg;					// *avg <- tmp_avg
	*passing_avg = tmp_passing_avg;			// *passing_avg <- tmp_passing_avg
	*num_passed = tmp_num_passed;			// *num_passed <- tmp_num_passed



}; //compute rank
