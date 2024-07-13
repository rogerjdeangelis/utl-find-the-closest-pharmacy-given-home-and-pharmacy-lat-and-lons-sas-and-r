%let pgm=utl-find-the-closest-pharmacy-given-home-and-pharmacy-lat-and-lons-sas-and-r;

Find the closest pharmacy given home and pharmacy lat and lons sas and r;

stackoverflow
https://tinyurl.com/2c5295mp
https://stackoverflow.com/questions/78739421/joining-lat-lon-data-frames-by-nearest-distance

    Two Solutions
       1 sas
       2 r

github
https://tinyurl.com/2enzyk2j
https://github.com/rogerjdeangelis/utl-find-the-closest-pharmacy-given-home-and-pharmacy-lat-and-lons-sas-and-r

Related REPO
-----------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-find-subsets-of-size-n-whose-sum-is-closest-to-a-desired-value

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/***************************************************************************************************************************/
/*                                                                                                                         */
/*  FIND PHARMACY CLOSEST RO HOMES                                                                                         */
/*                                                                                                                         */
/*-------------------------------------------------------------------------------------------------------------------------*/
/*                                                 |                                                                       */
/*  SD1.HOMES total obs=4                          | SD1.WANT total obs=4                                                  */
/*                                                 |                                                                       */
/*  ROWNAMES      LON        LAT          Y        |                                      PHARM_    PHARM_                 */
/*                                                 |  ROWNAMES MOME_LON    HOME_LAT      LON       LAT         Y    LINK   */
/*      1       0.91481    0.64175     0.40427     |                                                                       */
/*      2       0.93708    0.51910    -0.10612     |      1     0.91481     0.64175     1.00      0.75      0.40427   *1   */
/*      3       0.28614    0.73659     1.51152     |      2     0.93708     0.51910     1.00      0.50     -0.10612   *2   */
/*      4       0.83045    0.13467    -0.09466     |      3     0.28614     0.73659     0.25      0.75      1.51152   *3   */
/*                                                 |      4     0.83045     0.13467     0.75      0.25     -0.09466   *4   */
/*                                                 |                                                                       */
/*  SD1.PHARMACIES total obs=25 13JUL2024:12:42:33 |                                                                       */
/*                                                 |   Just eyeballing we can see that rows  the best matches              */
/*  ROWNAMES     LON     LAT                       |                                                                       */
/*                                                 |                                                                       */
/*      1       0.00    0.00                       |                                                                       */
/*      2       0.00    0.25                       |                                                                       */
/*      3       0.00    0.50                       |                                                                       */
/*      4       0.00    0.75                       |                                                                       */
/*      5       0.00    1.00                       |                                                                       */
/*      6       0.25    0.00                       |                                                                       */
/*      7       0.25    0.25                       |                                                                       */
/*      8       0.25    0.50                       |                                                                       */
/*      9       0.25    0.75 *3                    |                                                                       */
/*     10       0.25    1.00                       |                                                                       */
/*     11       0.50    0.00                       |                                                                       */
/*     12       0.50    0.25                       |                                                                       */
/*     13       0.50    0.50                       |                                                                       */
/*     14       0.50    0.75                       |                                                                       */
/*     15       0.50    1.00                       |                                                                       */
/*     16       0.75    0.00                       |                                                                       */
/*     17       0.75    0.25 *4                    |                                                                       */
/*     18       0.75    0.50                       |                                                                       */
/*     19       0.75    0.75                       |                                                                       */
/*     20       0.75    1.00                       |                                                                       */
/*     21       1.00    0.00                       |                                                                       */
/*     22       1.00    0.25                       |                                                                       */
/*     23       1.00    0.50  *2                   |                                                                       */
/*     24       1.00    0.75  *1                   |                                                                       */
/*     25       1.00    1.00                       |                                                                       */
/*                                                 |                                                                       */
/***************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libanme sd1 "d:/sd1";

options valivarname=upcase;
data sd1.home;
informat
ROWNAMES 3.
LON 8.
LAT 8.
Y 8.
;input
ROWNAMES LON LAT Y;
cards4;
1 0.9148060435 0.6417455189 0.4042683231
2 0.9370754133 0.5190959491 -0.106124516
3 0.2861395348 0.7365883146 1.5115219974
4 0.8304476261 0.1346665972 -0.094659038
;;;;
run;quit;

data sd1.pharmacies;
informat
ROWNAMES 3.
LON 8.
LAT 8.
;input
ROWNAMES LON LAT @@;
cards4;
1 0 0 2 0 0.25 3 0 0.5 4 0 0.75 5 0 1 6
0.25 0 7 0.25 0.25 8 0.25 0.5 9 0.25
0.75 10 0.25 1 11 0.5 0 12 0.5 0.25
13 0.5 0.5 14 0.5 0.75
15 0.5 1 16 0.75 0 17 0.75 0.25 18 0.75
0.5 19 0.75 0.75 20 0.75 1 21 1 0
22 1 0.25 23 1 0.5 24 1 0.75 25 1 1
;;;;
run;quit;

/***************************************************************************************************************************/
/*                                                                                                                         */
/*  SD1.HOMES total obs=4                                                                                                  */
/*                                                                                                                         */
/*  ROWNAMES      LON        LAT          Y                                                                                */
/*                                                                                                                         */
/*      1       0.91481    0.64175     0.40427                                                                             */
/*      2       0.93708    0.51910    -0.10612                                                                             */
/*      3       0.28614    0.73659     1.51152                                                                             */
/*      4       0.83045    0.13467    -0.09466                                                                             */
/*                                                                                                                         */
/*                                                                                                                         */
/*  SD1.PHARMACIES total obs=25 13JUL2024:12:42:33                                                                         */
/*                                                                                                                         */
/*  ROWNAMES     LON     LAT                                                                                               */
/*                                                                                                                         */
/*      1       0.00    0.00                                                                                               */
/*      2       0.00    0.25                                                                                               */
/*      3       0.00    0.50                                                                                               */
/*      4       0.00    0.75                                                                                               */
/*      5       0.00    1.00                                                                                               */
/*      6       0.25    0.00                                                                                               */
/*      7       0.25    0.25                                                                                               */
/*      8       0.25    0.50                                                                                               */
/*      9       0.25    0.75 *3                                                                                            */
/*     10       0.25    1.00                                                                                               */
/*     11       0.50    0.00                                                                                               */
/*     12       0.50    0.25                                                                                               */
/*     13       0.50    0.50                                                                                               */
/*     14       0.50    0.75                                                                                               */
/*     15       0.50    1.00                                                                                               */
/*     16       0.75    0.00                                                                                               */
/*     17       0.75    0.25 *4                                                                                            */
/*     18       0.75    0.50                                                                                               */
/*     19       0.75    0.75                                                                                               */
/*     20       0.75    1.00                                                                                               */
/*     21       1.00    0.00                                                                                               */
/*     22       1.00    0.25                                                                                               */
/*     23       1.00    0.50  *2                                                                                           */
/*     24       1.00    0.75  *1                                                                                           */
/*     25       1.00    1.00                                                                                               */
/*                                                                                                                         */
/***************************************************************************************************************************/

/*
/ |  ___  __ _ ___
| | / __|/ _` / __|
| | \__ \ (_| \__ \
|_| |___/\__,_|___/

*/

proc datasets lib=sd1 nolist nodetails;
  delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(sqldf);
library(haven)
source("c:/oto/fn_tosas9x.R");
data<-read_sas("d:/sd1/home.sas7bdat")
grid<-read_sas("d:/sd1/pharmacies.sas7bdat")
data
grid
prox<-sqldf('
 select
    l.lon as mome_lon
   ,l.lat as home_lat
   ,r.lon as pharm_lon
   ,r.lat as pharm_lat
   ,l.y
 from
    data as l left join grid as r
 group
    by l.lat, l.lon
 having
  power(l.lon-r.lon,2)+power(l.lat-r.lat,2) =
        min(power(l.lon-r.lon,2)+power(l.lat-r.lat,2))
 order
   by l.rownames

');
prox;
fn_tosas9x(
      inp    = prox
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.WANT total obs=4                                                                                                  */
/*                                                                                                                        */
/*                                       PHARM_    PHARM_                                                                 */
/*   ROWNAMES    MOME_LON    HOME_LAT      LON       LAT         Y                                                        */
/*                                                                                                                        */
/*       1        0.91481     0.64175     1.00      0.75      0.40427                                                     */
/*       2        0.93708     0.51910     1.00      0.50     -0.10612                                                     */
/*       3        0.28614     0.73659     0.25      0.75      1.51152                                                     */
/*       4        0.83045     0.13467     0.75      0.25     -0.09466                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___
|___ \   _ __
  __) | | `__|
 / __/  | |
|_____| |_|

*/

proc datasets lib=sd1 nolist nodetails;
  delete rwant;
run;quit;

options ls=255;
%utl_rbeginx;
parmcards4;
library(dplyr)
library(tidyr)
library(haven)
source("c:/oto/fn_tosas9x.R");
data<-read_sas("d:/sd1/home.sas7bdat")[,-1]
grid<-read_sas("d:/sd1/pharmacies.sas7bdat")[,-1]
rwant<- data |>
  dplyr::mutate(
    grid_index = dplyr::pick(LON, LAT) |>
      Rfast::dista(grid[c("LON", "LAT")]) |>
      Rfast::rowMins(),
    grid[grid_index, ] |> dplyr::rename_all(paste0, "_grid")
  )
rwant <- rwant %>% select ( -grid_index )
rwant
fn_tosas9x(
      inp    = rwant
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  R Output                                                                                                              */
/*                                                                                                                        */
/*      LON   LAT       Y LON_grid LAT_grid                                                                               */
/*                                                                                                                        */
/*    <dbl> <dbl>   <dbl>    <dbl>    <dbl>                                                                               */
/*  1 0.915 0.642  0.404      1        0.75                                                                               */
/*  2 0.937 0.519 -0.106      1        0.5                                                                                */
/*  3 0.286 0.737  1.51       0.25     0.75                                                                               */
/*  4 0.830 0.135 -0.0947     0.75     0.25                                                                               */
/*                                                                                                                        */
/*  SAS                                                                                                                   */
/*                                                                                                                        */
/*   ROWNAMES      LON        LAT          Y       LON_GRID    LAT_GRID                                                   */
/*                                                                                                                        */
/*       1       0.91481    0.64175     0.40427      1.00        0.75                                                     */
/*       2       0.93708    0.51910    -0.10612      1.00        0.50                                                     */
/*       3       0.28614    0.73659     1.51152      0.25        0.75                                                     */
/*       4       0.83045    0.13467    -0.09466      0.75        0.25                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
