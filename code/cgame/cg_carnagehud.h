#define	CA_CHAR_WIDTH		12
#define	CA_CHAR_HEIGHT		26
#define CA_ICON_SIZE        32
#define CA_MINI_CHAR_WIDTH  6
#define CA_MINI_CHAR_HEIGHT 13
#define CA_MINI_ICON_SIZE   16

extern int start_time;
extern int pow_of2[16];
extern int sh_id;
extern int acc_weap_h[MAX_WEAPONS],acc_weap_f[MAX_WEAPONS], last_acc_h, last_acc_f, col_f, col_h;

void CA_DrawMiniHealthBar(void);
void CA_DrawMiniArmourBar(void);
void CA_DrawMiniAmmoBar(void);
void CA_DrawMainHealthBar(void);
void CA_DrawMainArmourBar(void);
void CA_DrawMainAmmoBar(void);
void CA_DrawRewardsBar( void );
void CA_DrawStatusBar( void );
void CA_DrawWeaponSelect( void );
float CA_DrawPowerups( float y );
float CA_DrawScores( float y );
void CA_DrawHoldableItem( void );
