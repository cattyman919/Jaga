import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { VehicleReminderService } from './vehicle-reminder.service';
import { CreateVehicleReminderDto } from './dto/create-vehicle-reminder.dto';
import { UpdateVehicleReminderDto } from './dto/update-vehicle-reminder.dto';

@Controller('vehicle-reminder')
export class VehicleReminderController {
  constructor(
    private readonly vehicleReminderService: VehicleReminderService,
  ) { }

  @Post()
  create(@Body() createVehicleReminderDto: CreateVehicleReminderDto) {
    return this.vehicleReminderService.create(createVehicleReminderDto);
  }

  @Get()
  findAll() {
    return this.vehicleReminderService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.vehicleReminderService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateVehicleReminderDto: UpdateVehicleReminderDto,
  ) {
    return this.vehicleReminderService.update(+id, updateVehicleReminderDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.vehicleReminderService.remove(+id);
  }
}
