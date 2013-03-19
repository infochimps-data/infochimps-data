-- ===========================================================================
--
-- Fixes for 2012 Baseball Databank
--

-- correct a couple errors in the 2012 Baseball Databank (the 'January 9, 3:00 pm' release)

UPDATE `master`        SET `playerID` = 'baezjo01'  WHERE `lahmanID` = 460   AND `playerID` = 'baezda01';
UPDATE `master`        SET `bbrefID`  = 'snydech03' WHERE `lahmanID` = 19419 AND `playerID` = 'snydech03';
UPDATE `master`        SET `bbrefID`  = 'gilgahu01' WHERE `lahmanID` = 19417 AND `playerID` = 'gilgahu01';
UPDATE `AwardsPlayers` SET `playerID` = 'braunry02' WHERE `playerID` = 'braunry01' AND `awardID` = 'Silver Slugger' AND yearID = 2012 AND `lgID` = 'NL';
UPDATE `AwardsPlayers` SET `playerID` = 'brechha01' WHERE `playerID` = 'Brecheen'  AND `awardID` = 'Baseball Magazine All-Star';

-- Old players, validated by hand
UPDATE `master`        SET `bbrefID`  = 'sulliwi01' WHERE `lahmanID` = 19416 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mckenpa01' WHERE `lahmanID` = 19415 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mckenfr01' WHERE `lahmanID` = 19414 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'ruppeja99' WHERE `lahmanID` = 19420 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'defrato99' WHERE `lahmanID` = 19413 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'crossjo01' WHERE `lahmanID` = 19418 AND `bbrefID` IS NULL;

-- Validated by hand, as no direct name match
UPDATE `master`        SET `bbrefID`  = 'harriwi10' WHERE `lahmanID` = 19359 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'griffaj01' WHERE `lahmanID` = 19308 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'polloaj01' WHERE `lahmanID` = 19233 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'ramosaj01' WHERE `lahmanID` = 19391 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rosenbj01' WHERE `lahmanID` = 19300 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'fickch01'  WHERE `lahmanID` = 19279 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mitchdj01' WHERE `lahmanID` = 19248 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hoovejj01' WHERE `lahmanID` = 19242 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hoeslj01'  WHERE `lahmanID` = 19409 AND `bbrefID` IS NULL;

-- Validated by matching: (first+last name in bdb = common name in WAR; debut was 2012; WAR table year was 2012)
UPDATE `master`        SET `bbrefID`  = 'cespeyo01' WHERE `lahmanID` = 19207 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'galvifr01' WHERE `lahmanID` = 19208 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'pastoty01' WHERE `lahmanID` = 19209 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'aokino01'  WHERE `lahmanID` = 19210 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'gonzama01' WHERE `lahmanID` = 19211 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'komater01' WHERE `lahmanID` = 19212 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'komater01' WHERE `lahmanID` = 19212 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'vogtst01'  WHERE `lahmanID` = 19213 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cruzrh01'  WHERE `lahmanID` = 19214 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'flahery01' WHERE `lahmanID` = 19215 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'haguema01' WHERE `lahmanID` = 19216 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'kawasmu01' WHERE `lahmanID` = 19217 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'luetglu01' WHERE `lahmanID` = 19218 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'nieuwki01' WHERE `lahmanID` = 19219 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'oteroda01' WHERE `lahmanID` = 19220 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'jonesna01' WHERE `lahmanID` = 19221 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'phelpda01' WHERE `lahmanID` = 19222 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rossro01'  WHERE `lahmanID` = 19223 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'castile01' WHERE `lahmanID` = 19224 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'darviyu01' WHERE `lahmanID` = 19225 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'ramirer02' WHERE `lahmanID` = 19226 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'chenwe02'  WHERE `lahmanID` = 19227 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'smylydr01' WHERE `lahmanID` = 19228 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'carpeda02' WHERE `lahmanID` = 19229 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'linch01'   WHERE `lahmanID` = 19230 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'wielajo01' WHERE `lahmanID` = 19231 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'crawfev01' WHERE `lahmanID` = 19232 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'iwakuhi01' WHERE `lahmanID` = 19234 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'figuepe01' WHERE `lahmanID` = 19235 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hutchdr01' WHERE `lahmanID` = 19236 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'peralwi01' WHERE `lahmanID` = 19237 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'weberth01' WHERE `lahmanID` = 19238 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hefneje01' WHERE `lahmanID` = 19239 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'valdejo02' WHERE `lahmanID` = 19240 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'lutzza01'  WHERE `lahmanID` = 19241 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'harpebr03' WHERE `lahmanID` = 19243 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'moorety01' WHERE `lahmanID` = 19244 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'putkolu01' WHERE `lahmanID` = 19245 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'corbipa01' WHERE `lahmanID` = 19246 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'jennida01' WHERE `lahmanID` = 19247 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'middlwi01' WHERE `lahmanID` = 19249 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'exposlu01' WHERE `lahmanID` = 19250 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mikolmi01' WHERE `lahmanID` = 19251 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'faluir01'  WHERE `lahmanID` = 19252 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cardead01' WHERE `lahmanID` = 19253 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'doziebr01' WHERE `lahmanID` = 19254 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'pomerst01' WHERE `lahmanID` = 19255 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'quintjo01' WHERE `lahmanID` = 19256 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'friedch01' WHERE `lahmanID` = 19257 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'vanslsc01' WHERE `lahmanID` = 19258 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mattike01' WHERE `lahmanID` = 19259 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'averyxa01' WHERE `lahmanID` = 19260 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'costami01' WHERE `lahmanID` = 19261 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'culbech01' WHERE `lahmanID` = 19262 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'gomezma01' WHERE `lahmanID` = 19263 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'leonsa01'  WHERE `lahmanID` = 19264 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'diekmja01' WHERE `lahmanID` = 19265 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'herreel01' WHERE `lahmanID` = 19266 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'gomesya01' WHERE `lahmanID` = 19267 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'parkebl01' WHERE `lahmanID` = 19268 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'carsoro01' WHERE `lahmanID` = 19269 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'lallibl01' WHERE `lahmanID` = 19270 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'adamsma01' WHERE `lahmanID` = 19271 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hernago01' WHERE `lahmanID` = 19272 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hernago01' WHERE `lahmanID` = 19272 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'solando01' WHERE `lahmanID` = 19273 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'calhoko01' WHERE `lahmanID` = 19274 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'berryqu01' WHERE `lahmanID` = 19275 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'smithwi04' WHERE `lahmanID` = 19276 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'devrico01' WHERE `lahmanID` = 19277 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'diazju02'  WHERE `lahmanID` = 19278 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'gonzami03' WHERE `lahmanID` = 19280 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mercejo03' WHERE `lahmanID` = 19281 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'solanjh01' WHERE `lahmanID` = 19282 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'barnesc01' WHERE `lahmanID` = 19283 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'casteal01' WHERE `lahmanID` = 19284 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'crosbca01' WHERE `lahmanID` = 19285 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'freemsa01' WHERE `lahmanID` = 19286 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'grandya01' WHERE `lahmanID` = 19287 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'pryorst01' WHERE `lahmanID` = 19288 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'simmoan01' WHERE `lahmanID` = 19289 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'ramirel02' WHERE `lahmanID` = 19290 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'doolise01' WHERE `lahmanID` = 19291 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'holadbr01' WHERE `lahmanID` = 19292 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'danksjo02' WHERE `lahmanID` = 19293 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'negrokr01' WHERE `lahmanID` = 19294 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'schepta01' WHERE `lahmanID` = 19295 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'tollesh01' WHERE `lahmanID` = 19296 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'ortegjo01' WHERE `lahmanID` = 19297 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'robincl01' WHERE `lahmanID` = 19298 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'perezhe01' WHERE `lahmanID` = 19299 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'boxbebr01' WHERE `lahmanID` = 19301 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'kellyjo05' WHERE `lahmanID` = 19302 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'grimmju01' WHERE `lahmanID` = 19303 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'keuchda01' WHERE `lahmanID` = 19304 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'thornty01' WHERE `lahmanID` = 19305 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'archech01' WHERE `lahmanID` = 19306 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'norride01' WHERE `lahmanID` = 19307 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'roberty01' WHERE `lahmanID` = 19309 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'vinceni01' WHERE `lahmanID` = 19310 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cabreed01' WHERE `lahmanID` = 19311 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'perezma02' WHERE `lahmanID` = 19312 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'bauertr01' WHERE `lahmanID` = 19313 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'septile01' WHERE `lahmanID` = 19314 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'warread01' WHERE `lahmanID` = 19315 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'brownba01' WHERE `lahmanID` = 19316 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'downsda02' WHERE `lahmanID` = 19317 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'omogrbr01' WHERE `lahmanID` = 19318 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'dysonsa01' WHERE `lahmanID` = 19319 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mahonjo01' WHERE `lahmanID` = 19320 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'biancje01' WHERE `lahmanID` = 19321 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'edginjo01' WHERE `lahmanID` = 19322 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rutlejo01' WHERE `lahmanID` = 19323 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'avilalu01' WHERE `lahmanID` = 19324 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'loupaa01'  WHERE `lahmanID` = 19325 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'socolmi01' WHERE `lahmanID` = 19326 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'socolmi01' WHERE `lahmanID` = 19326 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'johnsst02' WHERE `lahmanID` = 19327 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'fifest01'  WHERE `lahmanID` = 19328 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'gosean01'  WHERE `lahmanID` = 19329 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'verdury01' WHERE `lahmanID` = 19330 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hernape02' WHERE `lahmanID` = 19331 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rosentr01' WHERE `lahmanID` = 19332 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'allenco01' WHERE `lahmanID` = 19333 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'wheelry01' WHERE `lahmanID` = 19334 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'belivje01' WHERE `lahmanID` = 19335 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'walljo02'  WHERE `lahmanID` = 19336 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'segurje01' WHERE `lahmanID` = 19337 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'segurje01' WHERE `lahmanID` = 19337 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'harvema01' WHERE `lahmanID` = 19338 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hendeji01' WHERE `lahmanID` = 19339 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'martest01' WHERE `lahmanID` = 19340 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'sierrmo01' WHERE `lahmanID` = 19341 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cabreal03' WHERE `lahmanID` = 19342 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'oltmi01'   WHERE `lahmanID` = 19343 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rodried04' WHERE `lahmanID` = 19344 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cappsca01' WHERE `lahmanID` = 19345 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'storemi01' WHERE `lahmanID` = 19346 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'straida01' WHERE `lahmanID` = 19347 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'burnsco01' WHERE `lahmanID` = 19348 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'hechaad01' WHERE `lahmanID` = 19349 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mcbrima02' WHERE `lahmanID` = 19350 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'jacksbr01' WHERE `lahmanID` = 19351 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'vittejo01' WHERE `lahmanID` = 19352 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'barnebr02' WHERE `lahmanID` = 19353 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'jenkich01' WHERE `lahmanID` = 19354 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'raleybr01' WHERE `lahmanID` = 19355 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'machama01' WHERE `lahmanID` = 19356 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'elmorja01' WHERE `lahmanID` = 19357 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'jacksry02' WHERE `lahmanID` = 19358 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'brantro01' WHERE `lahmanID` = 19360 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'layneto01' WHERE `lahmanID` = 19361 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'geltzst01' WHERE `lahmanID` = 19362 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'redmoto01' WHERE `lahmanID` = 19363 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mcpheky01' WHERE `lahmanID` = 19364 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'wilsoju10' WHERE `lahmanID` = 19365 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rusinch01' WHERE `lahmanID` = 19366 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'skaggty01' WHERE `lahmanID` = 19367 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'wernean01' WHERE `lahmanID` = 19368 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'aumonph01' WHERE `lahmanID` = 19369 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mchugco01' WHERE `lahmanID` = 19370 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'peguefr01' WHERE `lahmanID` = 19371 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'kellyca01' WHERE `lahmanID` = 19372 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cloydty01' WHERE `lahmanID` = 19373 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'lerudst01' WHERE `lahmanID` = 19374 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'garciav01' WHERE `lahmanID` = 19375 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'heathde01' WHERE `lahmanID` = 19376 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'holtbr01'  WHERE `lahmanID` = 19377 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'loughda01' WHERE `lahmanID` = 19378 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'perezeu01' WHERE `lahmanID` = 19379 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'maronni01' WHERE `lahmanID` = 19380 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'nealth01'  WHERE `lahmanID` = 19381 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'profaju01' WHERE `lahmanID` = 19382 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rodrihe04' WHERE `lahmanID` = 19383 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'machije01' WHERE `lahmanID` = 19384 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'phippde01' WHERE `lahmanID` = 19385 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'chapmja02' WHERE `lahmanID` = 19386 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'eatonad02' WHERE `lahmanID` = 19387 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'familje01' WHERE `lahmanID` = 19388 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'garcich02' WHERE `lahmanID` = 19389 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'jimenlu01' WHERE `lahmanID` = 19390 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'gregodi01' WHERE `lahmanID` = 19392 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'koehlto01' WHERE `lahmanID` = 19393 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'millesh01' WHERE `lahmanID` = 19394 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'villape01' WHERE `lahmanID` = 19395 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'grahaty01' WHERE `lahmanID` = 19396 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'triunca01' WHERE `lahmanID` = 19397 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'cingrto01' WHERE `lahmanID` = 19398 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rodrist02' WHERE `lahmanID` = 19399 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'scahiro01' WHERE `lahmanID` = 19400 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'morribr01' WHERE `lahmanID` = 19401 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'rufda01'   WHERE `lahmanID` = 19402 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'herrmch01' WHERE `lahmanID` = 19403 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'solisal01' WHERE `lahmanID` = 19404 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'fontwi01'  WHERE `lahmanID` = 19405 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'mesame01'  WHERE `lahmanID` = 19406 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'bundydy01' WHERE `lahmanID` = 19407 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'odorija01' WHERE `lahmanID` = 19408 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'tayloan01' WHERE `lahmanID` = 19410 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'ortegra01' WHERE `lahmanID` = 19411 AND `bbrefID` IS NULL;
UPDATE `master`        SET `bbrefID`  = 'brummty01' WHERE `lahmanID` = 19412 AND `bbrefID` IS NULL;

-- SELECT (CONCAT(peep.`nameFirst`, ' ', peep.`nameLast`) = bw.`nameCommon`) AS name_match,
--   peep.`lahmanID`, peep.`playerID`, bw.`bbrefID`, peep.`bbrefID`, bw.`lahmanID`, bw.yearID,
--   peep.`nameFirst`, peep.`nameLast`, bw.`nameCommon`
--   FROM people peep
--   LEFT JOIN `batting_war` bw ON (peep.`playerID` = bw.`bbrefID`)
--   WHERE (peep.`bbrefID` IS NULL) 
--   ORDER BY name_match ASC
--   ;

-- ===========================================================================
--
-- Restore Indices for 2012 Baseball Databank
--

-- Optional: re-add indexes; joins very slow without

ALTER TABLE `master`
  ADD UNIQUE KEY `playerID`  (`playerID`),
  ADD UNIQUE KEY `bbrefID`   (`bbrefID`),
  ADD UNIQUE KEY `retroID`   (`retroID`,`bbrefID`),
  ADD UNIQUE KEY `managerID` (`managerID`),
  ADD UNIQUE KEY `hofID`     (`hofID`)
  ;
ALTER TABLE Teams
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE TeamsHalf
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Batting
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Pitching
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Fielding
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE BattingPost
  ADD KEY `playerID` (`playerID`,`yearID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE PitchingPost
  ADD KEY `playerID` (`playerID`,`yearID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE FieldingPost
  ADD KEY `playerID` (`playerID`),
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`),
  ADD KEY `round`    (`yearID`,`round`,`teamID`,`lgID`)
  ;
ALTER TABLE Managers
  ADD KEY `team`     (`teamID`,`yearID`,`lgID`)
  ;
ALTER TABLE Salaries
  ADD KEY `playerID` (`playerID`,`yearID`,`lgID`)
  ;
ALTER TABLE Appearances
  ADD KEY `playerID` (`playerID`,`yearID`)
  ;
