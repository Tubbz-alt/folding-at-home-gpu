
all:
	sudo docker build . -t slaclab/fah:7.5.1 \
	&& sudo docker push slaclab/fah:7.5.1 \
	&& sudo singularity build /scratch/fah@7.5.1.sif Singularity \
	&& mv /scratch/fah@7.5.1.sif /afs/slac/package/singularity/images/fah/7.5.1/fah@7.5.1.sif
