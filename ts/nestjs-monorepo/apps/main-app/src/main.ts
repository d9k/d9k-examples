import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const port = process.env.port ?? 3000;
  const logger = new Logger('bootstrap');
  logger.log(`Starting first app on port ${port}`);

  await app.listen(port);
}
bootstrap();
