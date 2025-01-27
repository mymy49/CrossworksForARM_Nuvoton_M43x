#include <NuMicro.h>

#define FMC_ISPCMD_FLASH_READ					(0x00)
#define FMC_ISPCME_FLASH_READ_64BIT				(0x40)
#define FMC_ISPCMD_READ_UNIQUE_ID				(0x04)
#define FMC_ISPCMD_READ_FLASH_ALL_ONE_READ		(0x08)
#define FMC_ISPCMD_READ_COMPANY_ID				(0x0B)
#define FMC_ISPCMD_READ_DEVICE_ID				(0x0C)
#define FMC_ISPCMD_READ_CHECKSUM				(0x0D)
#define FMC_ISPCMD_FLASH_32BIT_PROGRAM			(0x21)
#define FMC_ISPCMD_FLASH_PAGE_ERASE				(0x22)
#define FMC_ISPCMD_FLASH_BANK_ERASE				(0x23)
#define FMC_ISPCMD_FLASH_BLOCK_ERASE			(0x25)
#define FMC_ISPCMD_FLASH_MULTI_WORD				(0x27)

void executeCommand(uint8_t cmd)
{
	FMC->ISPCTL |= FMC_ISPCTL_APUEN_Msk;
	FMC->ISPCMD = cmd;
	FMC->ISPTRG = FMC_ISPTRG_ISPGO_Msk;
	
	while(1)
	{
		if(~FMC->ISPTRG & FMC_ISPTRG_ISPGO_Msk)
			break;
	}

	FMC->ISPCTL &= ~FMC_ISPCTL_APUEN_Msk;
}

int Init(unsigned long adr, unsigned long clk, unsigned long fnc)
{
	SYS->REGLCTL = 0x59;
	SYS->REGLCTL = 0x16;
	SYS->REGLCTL = 0x88;

    return 0;
}

int UnInit(unsigned long fnc)
{
	SYS->REGLCTL = 0x00;

    return 0;
}

int BlankCheck(unsigned long adr, unsigned long sz, unsigned char pat)
{
    return 0;
}

int EraseChip(void)
{
    return 0;
}

int EraseSector(unsigned long adr)
{
	FMC->ISPCTL |= FMC_ISPCTL_ISPEN_Msk;
	
	FMC->ISPADDR = adr;

	executeCommand(FMC_ISPCMD_FLASH_PAGE_ERASE);

	FMC->ISPCTL &= ~FMC_ISPCTL_ISPEN_Msk;
	
	return 0;
}

int ProgramPage(unsigned long adr, unsigned long sz, unsigned char *buf)
{
	uint32_t *src = (uint32_t*)buf;
	uint32_t *addr = (uint32_t*)adr;

	FMC->ISPCTL |= FMC_ISPCTL_ISPEN_Msk;
	
	for(uint32_t i = 0; i < sz; i++)
	{ 
		FMC->ISPADDR = (uint32_t)addr++;
		FMC->MPDAT0 = *src++;

		executeCommand(FMC_ISPCMD_FLASH_32BIT_PROGRAM);
	}

	FMC->ISPCTL &= ~FMC_ISPCTL_ISPEN_Msk;

    return 0;
}

unsigned long Verify(unsigned long adr, unsigned long sz, unsigned char *buf)
{
    return 0;
}


