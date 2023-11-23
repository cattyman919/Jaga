import { IsString, IsNotEmpty, IsOptional, IsDateString, IsEnum, IsNumberString } from 'class-validator';
import { vehicle_type } from 'src/enums/vehicleType_enum';

export class UpdateVehicleDto {
    @IsString()
    @IsOptional()
    name: string | null

    @IsEnum({
        car: 'car',
        motorcycle: 'motorcycle'
    })
    @IsOptional()
    type: vehicle_type | null

    @IsDateString()
    @IsOptional()
    years: Date | null

    @IsNumberString()
    @IsOptional()
    kilometres: number | null;
}


