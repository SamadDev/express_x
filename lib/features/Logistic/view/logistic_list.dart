import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_express/Logistic/data/service/warehouse_service.dart';

class Logistic extends StatefulWidget {
  const Logistic({super.key});

  @override
  State<Logistic> createState() => _LogisticState();
}

class _LogisticState extends State<Logistic> {
  List<Warehouse> _warehouses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWarehouses();
  }

  Future<void> _loadWarehouses() async {
    try {
      final warehouses = await WarehouseService.fetchWarehouses();
      if (mounted) {
        setState(() {
          _warehouses = warehouses;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Error loading warehouses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _isLoading
          ? _buildShimmerLoading()
          : _warehouses.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No warehouses available',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _warehouses.map((warehouse) {
                      return _buildWarehouseCard(warehouse, context);
                    }).toList(),
                  ),
                ),
    );
  }

  Widget _buildShimmerLoading() {
    return SizedBox(
      height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            7,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWarehouseCard(Warehouse warehouse, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Fetch warehouse detail
        final detail =
            await WarehouseService.fetchWarehouseDetail(warehouse.id);
        if (detail != null && mounted) {
          // Show warehouse details dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(detail.name),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(detail.fullAddress),
                    SizedBox(height: 12),
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Phone: ${detail.phoneNumber}'),
                    Text('Email: ${detail.email}'),
                    SizedBox(height: 12),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('City: ${detail.city}'),
                    Text('Country: ${detail.country}'),
                    Text('Postal Code: ${detail.postalCode}'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              child: warehouse.image.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: warehouse.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        color: Colors.transparent,
                        child: Icon(Icons.warehouse,
                            color: Colors.grey[400], size: 24),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/${warehouse.image}",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.warehouse,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
                    )
                  : Image.asset(
                      "assets/images/${warehouse.image}",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.warehouse,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              warehouse.name,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
