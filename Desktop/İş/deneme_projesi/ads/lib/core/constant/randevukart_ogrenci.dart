import 'package:ads/core/models/randevumodel.dart';
import 'package:flutter/material.dart';

class RandevuKartiOgrenci extends StatelessWidget {
  final RandevuModel item;
  const RandevuKartiOgrenci({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: item.onayDurumu
            ? const Color.fromARGB(255, 197, 255, 227)
            : const Color.fromARGB(255, 249, 165, 165),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  item.baslik,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.mesaj,
                          style: const TextStyle(fontSize: 20),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Randevu Tarihi : '),
                          Text(item.tarih),
                        ],
                      ),
                      Text(
                        item.akademisyenName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
