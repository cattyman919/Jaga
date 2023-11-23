
import {
    IsString,
    IsNotEmpty,
    MinLength,
    IsOptional,
    IsEnum,
    IsNumber,
    IsDateString,
    IsNumberString,
} from 'class-validator';
import { vehicle_type } from 'src/enums/vehicleType_enum';

export class CreateVehicleDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsNumberString()
    @IsNotEmpty()
    userID: number;

    @IsEnum({
        car: 'car',
        motorcycle: 'motorcycle'
    })
    @IsNotEmpty()
    type: vehicle_type

    @IsDateString()
    @IsNotEmpty()
    years: Date;

    @IsNumberString()
    @IsOptional()
    kilometres: number;
}

