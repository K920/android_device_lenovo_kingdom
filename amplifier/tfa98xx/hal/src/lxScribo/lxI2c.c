/*
 * lxI2c.c
 *
 *  Created on: Apr 21, 2012
 *      Author: wim
 */
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <stdint.h>	
#include <fcntl.h>

#include "lxScribo.h"
#include "Tfa98xx.h"	// for i2c slave address
#include "Scribo.h"

int i2c_trace=0;
extern int tfa98xxI2cSlave;

#ifndef I2C_SLAVE
#define I2C_SLAVE	0x0703	/* dummy address for building API	*/
#endif

static void hexdump(int num_write_bytes, const unsigned char * data)
{
	int i;

	for(i=0;i<num_write_bytes;i++)
	{
		printf("0x%02x ", data[i]);
	}

}

void  lxI2cSlave(int fd, int slave)
{
    // open the slave
    int res = ioctl(fd, I2C_SLAVE, slave);
    if ( res < 0 ) {
        /* TODO ERROR HANDLING; you can check errno to see what went wrong */
        fprintf(stderr, "Can't open i2c slave:0x%02x\n", slave);
        _exit(res);
    }

    if (i2c_trace) printf("I2C slave=0x%02x\n", tfa98xxI2cSlave);

}

int lxI2cWriteRead(int fd, int NrOfWriteBytes, const uint8_t * WriteData,
		int NrOfReadBytes, uint8_t * ReadData, unsigned int *pError) {
	int ln = -1;

	// TODO redo checking
	if (WriteData[0] !=  (tfa98xxI2cSlave<<1)) {
		printf ("wrong slave 0x%02x iso0x%02x\n", WriteData[0]>>1, tfa98xxI2cSlave);
		return 0;
	}
	lxI2cSlave(fd, tfa98xxI2cSlave);

	if (NrOfWriteBytes & i2c_trace) {
		printf("W %d:", NrOfWriteBytes);
		hexdump (NrOfWriteBytes, WriteData);
		printf("\n");
	}

	if (NrOfWriteBytes > 2)

		ln = write(fd, &WriteData[1],  NrOfWriteBytes - 1);

	if (NrOfReadBytes) { // bigger
		//if ( (ReadData[0]>1) != (WriteData[0]>1) ) // if block read is different
		//		write(fd, &ReadData[0],  1);
		ln = write(fd, &WriteData[1],1); //write sub address
    if ( ln < 0 ) {
      *pError = eI2C_SLA_NACK; /* treat all errors as nack */
    } else {
      ln = read(fd,  &ReadData[1], NrOfReadBytes-1);
    }
  }

	if (NrOfReadBytes & i2c_trace) {
		printf("R %d:", NrOfReadBytes);
		hexdump (NrOfReadBytes, ReadData);
		printf("\n");
	}

	if ( ln < 0 ) {
		*pError = eI2C_SLA_NACK; /* treat all errors as nack */
		perror("i2c slave error");
	} else {
		*pError = eNone;
	}

	return ln+1;
}

int lxI2cWrite(int fd, int size, uint8_t *buffer, unsigned int *pError)
{
	return lxI2cWriteRead( fd, size, buffer, 0, NULL, pError);

}

int lxI2cInit(char *devname)
{
	int fd;

	fd = open(devname, O_RDWR | O_NONBLOCK, 0);
	if (fd < 0) {
		fprintf(stderr, "Can't open i2c bus:%s\n", devname);
		_exit(1);
	}

	lxI2cSlave(fd, tfa98xxI2cSlave);

	return fd;
}


