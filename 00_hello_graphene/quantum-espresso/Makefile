bands:
	../scripts/get_data.m graphene.bands.out 51
	../scripts/bands.m 3 11 19 20 21 22

calculate:
	mpirun -np 4 pw.x < graphene.scf.in > graphene.scf.out
	mpirun -np 4 pw.x < graphene.bands.in > graphene.bands.out
