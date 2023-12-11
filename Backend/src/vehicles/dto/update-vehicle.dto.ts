import { OmitType } from '@nestjs/mapped-types';
import { IsString, IsNotEmpty, IsOptional, IsDateString, IsEnum, IsNumberString } from 'class-validator';
import { CreateVehicleDto } from './create-vehicle.dto';

export class UpdateVehicleDto extends OmitType(CreateVehicleDto, ['userID'] as const) {


    @IsOptional()
    kilometres: number;

    @IsOptional()
    type: vehicle_type;

    @IsOptional()
    date: Date;

}
enum vehicle_type {
    car = 'car',
    motorcycle = 'motorcycle',
}


