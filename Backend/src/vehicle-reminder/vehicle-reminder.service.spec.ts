import { Test, TestingModule } from '@nestjs/testing';
import { VehicleReminderService } from './vehicle-reminder.service';

describe('VehicleReminderService', () => {
  let service: VehicleReminderService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [VehicleReminderService],
    }).compile();

    service = module.get<VehicleReminderService>(VehicleReminderService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
