Create Database TemisDB
go

USE [TemisDB]
GO
/****** Object:  Table [dbo].[Abogados]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abogados](
	[ID_Abogado] [int] NULL,
	[NombreAbogado] [varchar](25) NULL,
	[ApellidosAbogado] [varchar](25) NULL,
	[DUIAbogado] [varchar](10) NULL,
	[EspecialidadAbogado] [varchar](25) NULL,
	[TelefonoAbogado] [varchar](10) NULL,
	[EmailAbogado] [varchar](25) NULL,
	[CSJ] [varchar](25) NULL,
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Asistentes]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asistentes](
	[ID_Asistente] [int] NOT NULL,
	[pNombre] [varchar](50) NULL,
	[sNombre] [varchar](50) NULL,
	[pApellido] [varchar](50) NULL,
	[sApellido] [varchar](50) NULL,
	[DUI] [int] NULL,
	[WorkedHrs] [float] NULL,
 CONSTRAINT [PK_Asistentes] PRIMARY KEY CLUSTERED 
(
	[ID_Asistente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Casos]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Casos](
	[Case_ID] [int] NOT NULL,
	[Caso_Nombre] [varchar](50) NULL,
	[Tipo_Facturacion] [varchar](50) NULL,
	[Facturacion] [float] NULL,
 CONSTRAINT [PK_Casos] PRIMARY KEY CLUSTERED 
(
	[Case_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ID_Cliente] [int] NOT NULL,
	[PrimNombre] [varchar](50) NULL,
	[SegNombre] [varchar](50) NULL,
	[PrimApellido] [varchar](50) NULL,
	[SegApellido] [varchar](50) NULL,
	[DUI] [int] NULL,
	[Client_Edad] [int] NULL,
	[Nacionalidad] [varchar](50) NULL,
	[Ocupacion] [varchar](50) NULL,
	[Direccion] [varchar](500) NULL,
	[Telefono] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documentos]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documentos](
	[ID_Documento] [int] NULL,
	[Nombre_Documento] [varchar](50) NULL,
	[ID_Cliente] [int] NULL,
	[NombreCliente] [nchar](10) NULL,
	[Case_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[ID_Factura] [int] NOT NULL,
	[Case_ID] [int] NULL,
	[WorkedHrs] [float] NULL,
	[Caso_Nombre] [varchar](50) NULL,
	[Tipo_Facturacion] [varchar](50) NULL,
	[ID_Cliente] [int] NULL,
	[ID_Abogado] [int] NULL,
	[Nombre_Cliente] [varchar](100) NULL,
	[Nombre_Abogado] [varchar](1000) NULL,
 CONSTRAINT [PK_Facturaciones] PRIMARY KEY CLUSTERED 
(
	[ID_Factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID_Usuario] [int] NOT NULL,
	[Nombre_Usuario] [varchar](50) NULL,
	[Contraseña] [varchar](50) NULL,
	[Usuario_Inserta] [varchar](50) NULL,
	[Fecha_Inserta] [datetime] NULL,
	[Usuario_Modifica] [varchar](50) NULL,
	[Fecha_Modifica] [datetime] NULL,
	[ID_Asistente] [int] NULL,
	[ID_Abogado] [int] NULL,
	[Rol] [varchar](50) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[actualizar]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[actualizar] @id int ,@PrimerNombre varchar(50),@SegNombre varchar(50),@PrimApellido varchar(50),@SegApellido varchar(50),
@DUI int,@Client_Edad int,@Nacionalidad Varchar(50),@Ocupacion varchar(50),
@Direccion varchar(50),@Telefono Varchar (50),@Email varchar(100) as 
update Clientes set PrimNombre=@PrimerNombre,SegNombre=@SegNombre,PrimApellido=@PrimApellido,SegApellido=@SegApellido, DUI=@DUI, Client_Edad=@Client_Edad, 
Nacionalidad=@Nacionalidad,Ocupacion=@Ocupacion,Direccion=@Direccion,Telefono=@Telefono,Email=@Email
where ID_Cliente=@id
GO
/****** Object:  StoredProcedure [dbo].[datosusuarios]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[datosusuarios] as Select * from Clientes
GO
/****** Object:  StoredProcedure [dbo].[elimnar]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[elimnar] @id int as delete from Clientes where ID_Cliente=@id
GO
/****** Object:  StoredProcedure [dbo].[InsertarCliente]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarCliente]
	@id int,
    @PrimNombre VARCHAR(50),
    @SegNombre VARCHAR(50),
    @PrimApellido VARCHAR(50),
    @SegApellido VARCHAR(50),
    @DUI int,
    @Client_Edad INT,
    @Nacionalidad VARCHAR(50),
    @Ocupacion VARCHAR(50),
    @Direccion VARCHAR(100),
    @Telefono VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO clientes (ID_Cliente, SegNombre, PrimApellido, SegApellido, DUI, Client_Edad, Nacionalidad, Ocupacion, Direccion, Telefono, Email)
    VALUES (@id, @SegNombre, @PrimApellido, @SegApellido, @DUI, @Client_Edad, @Nacionalidad, @Ocupacion, @Direccion, @Telefono, @Email)
END
GO
/****** Object:  StoredProcedure [dbo].[llenar]    Script Date: 9/5/2024 17:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[llenar] @id int as 
select * from Clientes where ID_Cliente=@id
GO

commit
